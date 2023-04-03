import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kill_tiktok/features/users/models/user_profile_model.dart';
import 'package:kill_tiktok/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;
  @override
  FutureOr<UserProfileModel> build() {
    _repository = ref.read(userRepo);
    //유저가 아이디가 없어서 만들어야 할때
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception('account not created');
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      email: credential.user!.email ?? 'asdasd@com',
      name: credential.user!.displayName ?? 'anony',
      uid: credential.user!.uid,
      bio: 'undifined',
      link: 'undifined',
    );
    await _repository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
