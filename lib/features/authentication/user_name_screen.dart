import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/features/authentication/email_screen.dart';
import 'package:kill_tiktok/features/authentication/widgets/form_button.dart';

import '../../constants/sizes.dart';

class UsernameScreen extends StatefulWidget {
  static String routeName = '/username';
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = '';

  @override
  void initState() {
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if(_username.isEmpty) return;
    context.push(EmailScreen.routeName, extra: EmailScreenArgs(username: _username));
  }

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
          children: [
            Gaps.v40,
            const Text(
              'Create username',
              style: TextStyle(
                  fontSize: Sizes.size24, fontWeight: FontWeight.w700),
            ),
            Gaps.v8,
            const Text(
              'You can always change this later.',
              style: TextStyle(fontSize: Sizes.size16, color: Colors.black54),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: 'Username',
                //선택이 안됐을때
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),
            Gaps.v16,
            GestureDetector(
              child: FormButton(disabled: _username.isEmpty),
              onTap: () {
                _onNextTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}
