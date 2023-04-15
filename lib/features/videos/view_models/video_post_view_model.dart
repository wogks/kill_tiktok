import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kill_tiktok/features/authentication/repos/authen_repository.dart';
import 'package:kill_tiktok/features/videos/repositories/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final _videoId;
  @override
  FutureOr<void> build(String videoId) {
    _videoId = videoId;
    _repository = ref.read(videosRepo);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _repository.likeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
