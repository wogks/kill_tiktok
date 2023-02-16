import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/features/main_navigation/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final screens = const [
    Center(
      child: Text('home'),
    ),
    Center(
      child: Text('search'),
    ),
    Center(
      child: Text('search'),
    ),
    Center(
      child: Text('search'),
    ),
    Center(
      child: Text('search'),
    ),
  ];

  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: 'home',
                isSelected: _currentIndex == 0,
                icon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: 'discover',
                isSelected: _currentIndex == 1,
                icon: FontAwesomeIcons.magnifyingGlass,
                onTap: () => _onTap(1),
              ),
              NavTab(
                text: 'inbox',
                isSelected: _currentIndex == 3,
                icon: FontAwesomeIcons.message,
                onTap: () => _onTap(3),
              ),
              NavTab(
                text: 'profile',
                isSelected: _currentIndex == 4,
                icon: FontAwesomeIcons.user,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
