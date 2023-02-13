import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/gaps.dart';

import '../../constants/sizes.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Sign up',
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Gaps.v40,
            Text(
              'Create username',
              style:
                  TextStyle(fontSize: Sizes.size24, fontWeight: FontWeight.w700),
            ),
             Gaps.v8,
            Text(
              'You can always change this later.',
              style:
                  TextStyle(fontSize: Sizes.size16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
