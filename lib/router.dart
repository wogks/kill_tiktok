import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kill_tiktok/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:kill_tiktok/features/authentication/login_screen.dart';
import 'package:kill_tiktok/features/authentication/sign_up_screen.dart';
import 'package:kill_tiktok/features/inbox/activity_screen.dart';
import 'package:kill_tiktok/features/inbox/chat_detail_screen.dart';
import 'package:kill_tiktok/features/inbox/chats_screen.dart';
import 'package:kill_tiktok/features/onboarding/interests_screen.dart';
import 'package:kill_tiktok/features/videos/video_recording_screen.dart';

final router = GoRouter(
  initialLocation: '/inbox',
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
    ),
    GoRoute(
      path: '/:tab(home|discover|inbox|profile)',
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        final tab = state.params['tab']!;
        return MainNavigationScreen(tab: tab);
      },
    ),
    GoRoute(
      path: ActivityScreen.routeURL,
      name: ActivityScreen.routeName,
      builder: (context, state) => const ActivityScreen(),
    ),
    GoRoute(
        path: ChatScreen.routeURL,
        name: ChatScreen.routeName,
        builder: (context, state) => const ChatScreen(),
        //채팅방에 들어가면 상대방의 아이디로 자식 라우터를 만든다
        routes: [
          GoRoute(
              path: ChatDetailScreen.routeURL,
              name: ChatDetailScreen.routeName,
              builder: (context, state) {
                final chatId = state.params['chatId']!;
                return ChatDetailScreen(chatId: chatId);
              })
        ]),
    GoRoute(
      path: VideoRecordingScreen.routeURL,
      name: VideoRecordingScreen.routeName,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 150),
        child: const VideoRecordingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final position = Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(position: position, child: child);
        },
      ),
    ),
  ],
);
