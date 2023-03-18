import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/features/authentication/password_screen.dart';
import 'package:kill_tiktok/features/authentication/widgets/form_button.dart';

import '../../constants/sizes.dart';

class EmailScreenArgs{
  final String username;

  EmailScreenArgs({required this.username});


}

class EmailScreen extends StatefulWidget {
  static String routeName = '/emailscreen';

  final String username;

  const EmailScreen({super.key, required this.username});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = '';

  @override
  void initState() {
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    //이메일 형식 정규 표현식
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return 'Email not valid';
    }
    return null;
  }

  void _onScaffoldTap() {
    //unfocus
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PasswordScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
              Text(
                'What is your email?, ${widget.username}',
                style: const TextStyle(
                    fontSize: Sizes.size24, fontWeight: FontWeight.w700),
              ),
              Gaps.v16,
              TextField(
                //이메일 입력 형식
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: _emailController,
                onEditingComplete: _onSubmit,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  errorText: _isEmailValid(),
                  hintText: 'Email',
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
              GestureDetector
              (onTap: _onSubmit,
                child: FormButton(disabled: _email.isEmpty || _isEmailValid() != null)),
            ],
          ),
        ),
      ),
    );
  }
}
