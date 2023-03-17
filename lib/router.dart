import 'package:go_router/go_router.dart';
import 'package:kill_tiktok/features/authentication/email_screen.dart';
import 'package:kill_tiktok/features/authentication/login_screen.dart';
import 'package:kill_tiktok/features/authentication/sign_up_screen.dart';
import 'package:kill_tiktok/features/authentication/user_name_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: SignUpScreen.routeName,
        builder: (context, state) => const SignUpScreen()),
    GoRoute(
        path: EmailScreen.routeName,
        builder: (context, state) => const EmailScreen()),
    GoRoute(
        path: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: UsernameScreen.routeName,
        builder: (context, state) => const UsernameScreen()),
  ],
);
