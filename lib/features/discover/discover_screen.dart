import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //탭바를 사용하려면 컨트롤러가 있어야하는데 스캐폴드를 컨트롤러로 감싸면서 이 문제를 해결한다
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text('Discover'),
          bottom: TabBar(
            //클릭효과 삭제
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            //위젯의 리스트
            tabs: [
              for (var tab in tabs) Text(tab),
            ],
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: Sizes.size16),
          ),
        ),
        body: TabBarView(
          children: [
            for (var tab in tabs)
              Center(
                child: Text(tab),
              ),
          ],
        ),
      ),
    );
  }
}
