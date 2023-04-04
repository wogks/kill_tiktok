import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kill_tiktok/features/authentication/repos/authen_repository.dart';
import 'package:kill_tiktok/features/users/models/user_profile_model.dart';
import 'package:kill_tiktok/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;
  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    //유저가 아이디가 없어서 만들어야 할때
    return UserProfileModel.empty();
  }

  Future<void> createProfile(
      {required User user, String? birthday, String? name}) async {
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      email: user.email ?? 'asdasd@com',
      name: name ?? 'anony',
      uid: user.uid,
      bio: 'undifined',
      link: 'undifined',
      birthday: birthday ?? 'aaa',
    );
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncData(state.value!.copyWith(hasAvatar: true));
    await _usersRepository.updateUser(state.value!.uid, {'hasAvatar': true});
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
