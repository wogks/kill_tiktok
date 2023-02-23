import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

//이론적으로 방금 코멘트 화면을 새로 푸시 했기때문에 백버튼이 생긴다 새로운 스크린으로 네비게이트 한것이다
//백버튼 누르면 네비게이트 팝이 된다.
class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //리스트뷰ㅡ 이것저것 들어가야되기 때문에 스캐폴드를 넣는다
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size16, vertical: Sizes.size10),
      clipBehavior: Clip.hardEdge,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(Sizes.size14)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('1231231comments'),
          //back button dissapear
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => Gaps.v20,
          itemCount: 10,
          itemBuilder: (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18,
                child: Text('JH'),
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'james cheong',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    ),
                    const Text(
                        'as;djf asdfbewfasdfbewfasdfbewfasdfbewfasdfbewfasdfbewf sadf wef '),
                  ],
                ),
              ),
              Gaps.h10,
              Column(
                children: [
                  FaIcon(FontAwesomeIcons.heart, color: Colors.grey.shade500),
                  Gaps.v2,
                  Text(
                    '90.2K',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
