import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/features/authentication/birthday_screen.dart';
import 'package:kill_tiktok/features/authentication/widgets/form_button.dart';

import '../../constants/sizes.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = '';

  bool _obscureText = true;

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  void _onScaffoldTap() {
    //unfocus
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const BirthdayScreen()));
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    if (_obscureText == true) {
      _obscureText = false;
    } else {
      _obscureText = true;
    }
    setState(() {});
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
              const Text(
                'Password',
                style: TextStyle(
                    fontSize: Sizes.size24, fontWeight: FontWeight.w700),
              ),
              Gaps.v16,
              TextField(
                obscureText: _obscureText,
                //이메일 입력 형식
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: _passwordController,
                onEditingComplete: _onSubmit,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          onTap: _onClearTap,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade500,
                          )),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                  hintText: 'password',
                  //선택이 안됐을때
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
              Gaps.v10,
              const Text(
                'Your password must have:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h5,
                  const Text('8 to 20 charactors')
                ],
              ),
              Gaps.v16,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(disabled: !_isPasswordValid()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
