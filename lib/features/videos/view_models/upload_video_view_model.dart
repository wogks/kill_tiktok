import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kill_tiktok/features/authentication/repos/authen_repository.dart';
import 'package:kill_tiktok/features/videos/repositories/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideoRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  uploadVideoFile() {}
  Future<void> uploadVideo(File video) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.uploadVideoFile(video, user!.uid);
    });
  }
}
