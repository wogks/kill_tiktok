import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<String> _notifications = List.generate(20, (index) => '${index}h');

  void _onDismissed(String notification) {
    //옆으로 슬라이드할때 진짜로 지우는 메서드
    _notifications.remove(notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Activity'),
      ),
      body: ListView(
        children: [
          Gaps.v14,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'New',
              style: TextStyle(
                  fontSize: Sizes.size14, color: Colors.grey.shade500),
            ),
          ),
          Gaps.v14,
          for (var notification in _notifications)
            //밀어서 삭제
            Dismissible(
              onDismissed: (direction) => _onDismissed(notification),
              key: Key(notification),
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
                minVerticalPadding: Sizes.size16,
                //padding of listile
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: Sizes.size10),
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
                        text: '$notification',
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
