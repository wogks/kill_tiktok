import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/sizes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  List<int> _items = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(_items.length);
      _items.add(_items.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
        elevation: 1,
        title: const Text('Dm'),
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
        itemBuilder: (context, index, animation) {
          //페이드 효과를 준다
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              //사이즈 효과
              sizeFactor: animation,
              child: ListTile(
                //플로터나 애미메이셔닝 유니크키 때문에 헷갈리지 않는다
                key: UniqueKey(),
                leading: const CircleAvatar(
                  radius: 30,
                  child: Text('JH'),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('jae $index',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
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
            ),
          );
        },
      ),
    );
  }
}
