import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kill_tiktok/features/authentication/repos/authen_repository.dart';
import 'package:kill_tiktok/features/users/view_models/users_view_model.dart';
import 'package:kill_tiktok/features/videos/models/video_model.dart';
import 'package:kill_tiktok/features/videos/repositories/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideoRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  uploadVideoFile() {}
  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final task = await _repository.uploadVideoFile(video, user!.uid);
        if (task.metadata != null) {
          await _repository.saveVideo(VideoModel(
            creator: userProfile.name,
            title: 'from flutter!',
            description: 'from flutter!!!!',
            fileUrl: await task.ref.getDownloadURL(),
            thumbnailUrl: '',
            likes: 0,
            comments: 0,
            creatorUid: user.uid,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ));
        }
      });
      context.pushReplacement('/');
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
