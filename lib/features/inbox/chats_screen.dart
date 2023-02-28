import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/features/inbox/chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];
  final _duration = const Duration(milliseconds: 300);

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(0);
      _items.add(0);
    }
  }

  void _deleteItem(index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(
            color: Colors.red,
            child: _makeTile(index),
          ),
        ),
        duration: _duration,
      );

      _items.remove(index);
    }
  }

  void _onChattab() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ChatDetailScreen()));
  }

  Widget _makeTile(index) {
    return ListTile(
      onTap: _onChattab,
      onLongPress: () => _deleteItem(index),
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
            style:
                TextStyle(color: Colors.grey.shade500, fontSize: Sizes.size12),
          ),
        ],
      ),
      subtitle: const Text('dont forget to make video'),
    );
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
                child: _makeTile(index)),
          );
        },
      ),
    );
  }
}
