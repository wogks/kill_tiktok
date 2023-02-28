import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/sizes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
        elevation: 1,
        title: const Text('Dm'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              child: Text('JH'),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('jae han',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                //const Spacer(),
                Text(
                  '2:16 PM',
                  style: TextStyle(
                      color: Colors.grey.shade500, fontSize: Sizes.size12),
                ),
              ],
            ),
            subtitle: const Text('dont forget to make video'),
          ),
        ],
      ),
    );
  }
}
