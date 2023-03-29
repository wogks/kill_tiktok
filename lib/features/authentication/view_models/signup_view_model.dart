import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kill_tiktok/features/authentication/repos/authen_repository.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);

    state = await AsyncValue.guard(
        () async => await _authRepo.signUp(form['email'], form['password']));
  }
}

final signUpForm = StateProvider((ref) => {});
final signupProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
