import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/sizes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tiktok killer',
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
      ),
      home: Padding(
        padding: const EdgeInsets.all(Sizes.size14),
        child: Container(),
      ),
    );
  }
}
