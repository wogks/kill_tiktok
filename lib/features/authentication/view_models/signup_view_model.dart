import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kill_tiktok/features/authentication/repos/authen_repository.dart';
import 'package:kill_tiktok/features/onboarding/interests_screen.dart';

import '../../../utils.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);

    state = await AsyncValue.guard(
        () async => await _authRepo.signUp(form['email'], form['password']));
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(InterestScreen.routeName);
    }
  }
}

final signUpForm = StateProvider((ref) => {});
final signupProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
