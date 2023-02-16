import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/gaps.dart';

import '../../constants/sizes.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          //옆으로 슬라이드 하는 앱
          //탭바는 탭바컨트롤러가 필요한데 스캐폴드를 디폴트탭바컨트롤러로 감싸주면 된다
          child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v52,
                    Text(
                      'Watch cool videos!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Sizes.size40),
                    ),
                    Gaps.v16,
                    Text(
                      'Videos are personalized for you based on what you wath, like, and share.',
                      style: TextStyle(fontSize: Sizes.size20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v52,
                    Text(
                      'follow the rules!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Sizes.size40),
                    ),
                    Gaps.v16,
                    Text(
                      'Videos are personalized for you based on what you wath, like, and share.',
                      style: TextStyle(fontSize: Sizes.size20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Gaps.v52,
                    Text(
                      'enjoy the ride!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Sizes.size40),
                    ),
                    Gaps.v16,
                    Text(
                      'Videos are personalized for you based on what you wath, like, and share.',
                      style: TextStyle(fontSize: Sizes.size20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                //페이지 번호, 같은 디폴트탭컨트롤러에 있어야된다
                TabPageSelector(
                  color: Colors.white,
                  selectedColor: Colors.black38,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
