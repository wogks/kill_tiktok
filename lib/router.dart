import 'package:go_router/go_router.dart';
import 'package:kill_tiktok/features/authentication/email_screen.dart';
import 'package:kill_tiktok/features/authentication/login_screen.dart';
import 'package:kill_tiktok/features/authentication/sign_up_screen.dart';
import 'package:kill_tiktok/features/authentication/user_name_screen.dart';
import 'package:kill_tiktok/features/users/user_profile_screen.dart';

final router = GoRouter(
  initialLocation: LoginScreen.routeName,
  routes: [
    GoRoute(
        path: SignUpScreen.routeName,
        builder: (context, state) => const SignUpScreen()),
    GoRoute(
        path: EmailScreen.routeName,
        builder: (context, state) {
          final args = state.extra as EmailScreenArgs;
          return  EmailScreen(username: args.username);
        }),
    GoRoute(
        path: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: UsernameScreen.routeName,
        builder: (context, state) => const UsernameScreen()),
    GoRoute(
      path: 'users/:lynn?show=likes',
      builder: (context, state) {
        final username = state.params['username'];
        final tab = state.queryParams['show'];
        print(state.params);
        return UserProfileScreen(username: username!, tab: tab!);
      },
    )
  ],
);
