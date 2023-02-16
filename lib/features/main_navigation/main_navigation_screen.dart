import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  MainNavigationScreen({super.key});
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
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        //네비게이션바 색깔변경 강제
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: _onTap,
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            tooltip: 'what are u',
            label: 'home',
            icon: FaIcon(FontAwesomeIcons.house),
            backgroundColor: Colors.amber
          ),
          BottomNavigationBarItem(
            label: 'search',
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            tooltip: 'what are u',
            label: 'home',
            icon: FaIcon(FontAwesomeIcons.house),
            backgroundColor: Colors.pink
          ),
          BottomNavigationBarItem(
            label: 'search',
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            backgroundColor: Colors.yellow
          ),
          BottomNavigationBarItem(
            tooltip: 'what are u',
            label: 'home',
            icon: FaIcon(FontAwesomeIcons.house),
            backgroundColor: Colors.teal
          ),
          
        ],
      ),
    );
  }
}
