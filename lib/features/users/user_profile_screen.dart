import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/sizes.dart';

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
          //살짝만 내려도 앱바 전체가 내려온다 쿵!
          //  snap: true,
          //밑으로 당기면 앱바가 보임
          // floating: true,
          //밑으로 당기면 늘어난다
          stretch: true,
          //앱바를 고정한다
          pinned: true,
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
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            //아이템카운트 느낌
            childCount: 50,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text('$index'),
              ),
            ),
          ),
          //유닛들의 높이
          itemExtent: 100,
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.blue[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text('$index'),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //그리드의 높이
            maxCrossAxisExtent: 100,
            mainAxisSpacing: Sizes.size10,
            crossAxisSpacing: Sizes.size10,
            //사각형의 비율
            childAspectRatio: 1,
          ),
        ),
      ],
    );
  }
}
