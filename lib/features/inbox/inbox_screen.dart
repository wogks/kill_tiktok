import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/features/inbox/activity_screen.dart';

import '../../constants/gaps.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  void _onDmPressed() {}

  void _onActivityTab(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ActivityScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        elevation: 1,
        actions: [
          IconButton(
              onPressed: _onDmPressed,
              icon: const FaIcon(FontAwesomeIcons.paperPlane))
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _onActivityTab(context),
            title: const Text(
              'activity',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: Sizes.size16),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          Container(height: Sizes.size1, color: Colors.grey.shade200),
          Gaps.v8,
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'new followers',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: Sizes.size16),
            ),
            subtitle: const Text(
              'messages from followers will appear here',
              style: TextStyle(fontSize: Sizes.size14),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
