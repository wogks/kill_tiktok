import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kill_tiktok/features/authentication/repos/authen_repository.dart';
import 'package:kill_tiktok/features/users/repos/user_repo.dart';

class AvatarVieModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
        () async => await _repository.uploadAvatar(file, fileName));
  }
}
