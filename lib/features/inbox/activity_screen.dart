import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Activity'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        children: [
          Gaps.v14,
          Text(
            'New',
            style:
                TextStyle(fontSize: Sizes.size14, color: Colors.grey.shade500),
          ),
          Gaps.v14,
          //밀어서 삭제
          Dismissible(
            key: const Key('X'),
            background: Container(
              //아이콘 위치
              alignment: Alignment.centerLeft,
              color: Colors.amber,
              child: const Padding(
                padding: EdgeInsets.only(left: Sizes.size10),
                child: FaIcon(FontAwesomeIcons.check,
                    color: Colors.white, size: Sizes.size32),
              ),
            ),
            secondaryBackground: Container(
              //아이콘 위치
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.only(right: Sizes.size10),
                child: FaIcon(FontAwesomeIcons.trashCan,
                    color: Colors.white, size: Sizes.size32),
              ),
            ),
            child: ListTile(
              //padding of listile
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: Sizes.size52,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey.shade400, width: Sizes.size1),
                    shape: BoxShape.circle,
                    color: Colors.white),
                child: const Center(
                    child: FaIcon(
                  FontAwesomeIcons.bell,
                  color: Colors.black,
                )),
              ),
              title: RichText(
                text: TextSpan(
                  text: 'Account updates:',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: Sizes.size16),
                  children: [
                    const TextSpan(
                      text: " upload longer viddeos",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: " 1h",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
              trailing: const FaIcon(
                FontAwesomeIcons.chevronRight,
                size: Sizes.size20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
