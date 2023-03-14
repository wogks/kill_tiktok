import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({super.key, required this.inverted});
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return Stack(
      //스택은 스택크기 바깥에 있는것들을 다 자른다(clip) 클립을 사용하지 않아야 겹치게 보이는게 가능
      clipBehavior: Clip.none,
      children: [
        //positioned 스택 내부의 엘레멘트를 이동시킬 수 있게 해준다
        Positioned(
          right: 20,
          child: Container(
            height: 30,
            width: 25,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size8),
              color: const Color(0xff61d4f0),
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: Container(
            height: 30,
            width: 25,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size8),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Container(
          //스택의 기준접이 된다
          //컨테이너 크기지정을 안하면 컴테이너가 잡아먹는다.
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size6),
              color: !inverted ? Colors.white : Colors.black),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: inverted ? Colors.white : Colors.black,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
