import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/screens/sign_up/sign_up_screen.dart';

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
        primaryColor: const Color(0xFFE9435A),
      ),
      home: const SignUpScreen()
    );
  }
}
