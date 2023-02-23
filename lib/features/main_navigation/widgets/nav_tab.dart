import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/gaps.dart';

class NavTab extends StatelessWidget {
  const NavTab(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.icon,
      required this.selectedIcon,
      required this.onTap});

  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isSelected ? 1 : 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              isSelected ? selectedIcon : icon,
              color: Colors.white,
            ),
            Gaps.v5,
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}