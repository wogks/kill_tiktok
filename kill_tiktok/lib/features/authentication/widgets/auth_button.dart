import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  const AuthButton({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    //FractionallySizedBox:박스 위젯 부모의 크기에 비례해서 크기를 정해주는 위젯
    //부모의 크기가 1000픽셀, widthfactor가 1이면  부모너비의 100퍼의 박스너비를 가진다
    //1000px 0.5 = 500px 상대적 너비
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: const EdgeInsets.all(Sizes.size14),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
            width: Sizes.size1,
          ),
        ),
        //로우 대신 스택을 사용함으로써 텍스트를 가운데에 배치할수 있다
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(alignment: Alignment.centerLeft, child: icon),
            Text(
              text,
              style: const TextStyle(
                  fontSize: Sizes.size16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
