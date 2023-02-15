import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/features/authentication/widgets/form_button.dart';
import 'package:kill_tiktok/features/onboarding/interests_screen.dart';

import '../../constants/sizes.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdatController = TextEditingController();

  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    _setTextfieldDate(initialDate);
    super.initState();
  }

  @override
  void dispose() {
    _birthdatController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const InterestScreen(),),);
  }

  void _setTextfieldDate(DateTime date) {
    final textDate = date.toString().split(' ').first;
    //텍스트 필드에 바로 데이타임이 나오게 하는법
    //value가 텍스트필드에 반영된다
    _birthdatController.value = TextEditingValue(text: textDate);
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
              'When is your birthday',
              style: TextStyle(
                  fontSize: Sizes.size24, fontWeight: FontWeight.w700),
            ),
            Gaps.v8,
            const Text(
              'Your birthday wont be shown publicly.',
              style: TextStyle(fontSize: Sizes.size16, color: Colors.black54),
            ),
            Gaps.v16,
            TextField(
              enabled: false,
              controller: _birthdatController,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
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
              child: const FormButton(disabled: false),
              onTap: () {
                _onNextTap();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            //사용자가 미래의 날짜를 결정할수 없게 만든다
            maximumDate: initialDate,
            initialDateTime: initialDate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextfieldDate,
          ),
        ),
      ),
    );
  }
}
