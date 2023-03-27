import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/features/discover/discover_screen.dart';
import 'package:kill_tiktok/features/inbox/inbox_screen.dart';
import 'package:kill_tiktok/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:kill_tiktok/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:kill_tiktok/features/users/user_profile_screen.dart';

import '../../../features/videos/views/video_recording_screen.dart';
import '../../../features/videos/views/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = 'mainNavigation';
  final String tab;
  const MainNavigationScreen({super.key, required this.tab});
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    'home',
    'discover',
    //비디오찍는용의 가짜탭
    'xxxx',
    'inbox',
    'profile',
  ];

  late int _currentIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go('/${_tabs[index]}');
    setState(() {
      _currentIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
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
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _currentIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _currentIndex != 4,
            child: const UserProfileScreen(
              username: 'Wogks',
              tab: '',
            ),
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
