import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/features/authentication/widgets/form_button.dart';

import '../../constants/sizes.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _onSubmitTap() {
    //formkey를 통해 currentstate에 접근한다
    //validate: currentState가 있을수도 없을수도 있기 때문에 아무렇게나 접근 불가능(널체크 해야한다)

    //널체크를 통해 메서드 호출
    // if (_formkey.currentState != null) {
    //   _formkey.currentState!.validate();
    // }

    //커런트 스테이트가 있으면 발리데이트를 해라 하는 방법 없으면 아무것도 하지마라
    //_formkey.currentState?.validate();

    if (_formkey.currentState != null) {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
      }
      print(formData.values);
    }
  }

  Map<String, String> formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('login'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Gaps.v28,
                  TextFormField(
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['email'] = newValue;
                      }
                    },
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      return null;
                    },
                  ),
                  Gaps.v16,
                  TextFormField(
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['password'] = newValue;
                      }
                    },
                    decoration: InputDecoration(hintText: 'password'),
                    validator: (value) {
                      // if(value!.isNotEmpty) {
                      //   if(value.length<3) {
                      //     return 'error';
                      //   }
                      //   return null;
                      // }
                      return null;
                    },
                  ),
                  Gaps.v28,
                  GestureDetector(
                      onTap: _onSubmitTap,
                      child: const FormButton(disabled: false)),
                ],
              )),
        ));
  }
}
