import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //스크롤뷰의 일환
      slivers: [
        //앱바같지만 스크롤이 가능하다
        SliverAppBar(
          //밑으로 당기면 늘어난다
          floating: true,
          stretch: true,
          //앱바를 고정한다
          //pinned: true,
          backgroundColor: Colors.amber,
          //80까지 줄어들수 있고 으 이후에는 타이틀이 사라진다
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              //StretchMode.fadeTitle,
              StretchMode.zoomBackground
            ],
            background: Image.asset(
              'assets/images/1.jpeg',
              fit: BoxFit.cover,
            ),
            title: const Text('hello'),
          ),
        ),
      ],
    );
  }
}
