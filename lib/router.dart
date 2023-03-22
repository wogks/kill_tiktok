import 'package:go_router/go_router.dart';
import 'package:kill_tiktok/features/authentication/login_screen.dart';
import 'package:kill_tiktok/features/authentication/sign_up_screen.dart';
import 'package:kill_tiktok/features/onboarding/interests_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestScreen.routeName,
      path: InterestScreen.routeURL,
      builder: (context, state) => const InterestScreen(),
    )
  ],
);
