import 'package:flutter/material.dart';
import 'package:kill_tiktok/features/onboarding/interests_screen.dart';

import 'constants/sizes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'tiktok killer',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFE9435A),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const InterestScreen());
  }
}
