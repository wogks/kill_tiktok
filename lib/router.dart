import 'package:go_router/go_router.dart';
import 'package:kill_tiktok/features/videos/video_recording_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const VideoRecordingScreen(),
    )
  ],
);
