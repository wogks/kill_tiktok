import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/features/main_navigation/widgets/nav_tab.dart';
import 'package:kill_tiktok/features/main_navigation/widgets/post_video_button.dart';
import 'package:kill_tiktok/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('record video'),
          ),
        ),
        //모든 화면을 덮는다
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //댓글창에서 키보드를 사용해도 화면이 찌그러지지 않음
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
            offstage: _currentIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _currentIndex != 1,
            child: Container(),
          ),
          Offstage(
            offstage: _currentIndex != 3,
            child: Container(),
          ),
          Offstage(
            offstage: _currentIndex != 4,
            child: Container(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _currentIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                  text: 'home',
                  isSelected: _currentIndex == 0,
                  icon: FontAwesomeIcons.house,
                  selectedIcon: FontAwesomeIcons.house,
                  onTap: () => _onTap(0),
                  selectedIndex: _currentIndex),
              NavTab(
                  text: 'discover',
                  isSelected: _currentIndex == 1,
                  icon: FontAwesomeIcons.compass,
                  selectedIcon: FontAwesomeIcons.solidCompass,
                  onTap: () => _onTap(1),
                  selectedIndex: _currentIndex),
              Gaps.h24,
              GestureDetector(
                  onTap: _onPostVideoButtonTap,
                  child: PostVideoButton(inverted: _currentIndex != 0)),
              Gaps.h24,
              NavTab(
                  text: 'inbox',
                  isSelected: _currentIndex == 3,
                  icon: FontAwesomeIcons.message,
                  selectedIcon: FontAwesomeIcons.solidMessage,
                  onTap: () => _onTap(3),
                  selectedIndex: _currentIndex),
              NavTab(
                  text: 'profile',
                  isSelected: _currentIndex == 4,
                  icon: FontAwesomeIcons.user,
                  selectedIcon: FontAwesomeIcons.solidUser,
                  onTap: () => _onTap(4),
                  selectedIndex: _currentIndex),
            ],
          ),
        ),
      ),
    );
  }
}
