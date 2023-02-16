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
        bottomNavigationBar:
            //마테리얼디자인3
            NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _currentIndex,
          onDestinationSelected: _onTap,
          destinations: const [
            NavigationDestination(
                icon: FaIcon(
                  FontAwesomeIcons.house,
                  color: Colors.teal,
                ),
                label: 'home'),
            NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.magnifyingGlass,
                    color: Colors.amber),
                label: 'search'),
          ],
        ));
  }
}
