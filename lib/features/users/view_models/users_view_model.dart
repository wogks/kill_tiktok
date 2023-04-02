import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kill_tiktok/features/users/models/user_profile_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() {
    //유저가 아이디가 없어서 만들어야 할때
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception('account not created');
    }
    state = AsyncValue.data(UserProfileModel(
      email: credential.user!.email ?? 'asdasd@com',
      name: credential.user!.displayName ?? 'anony',
      uid: credential.user!.uid,
      bio: 'undifined',
      link: 'undifined',
    ));
  }
}

final usersProvider = AsyncNotifierProvider(
  () => UsersViewModel(),
);
