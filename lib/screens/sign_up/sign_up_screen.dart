import 'package:flutter/material.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            Text("Sign Up For TikTok")
          ],
        ),
      ),
    );
  }
}