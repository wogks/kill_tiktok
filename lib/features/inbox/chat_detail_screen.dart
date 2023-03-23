import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = 'chatDetail';
  //전체 경로는 /chats/:id 자식경로는 /로 시작할 수 없다
  static const String routeURL = ':id';
  final String chatId;
  const ChatDetailScreen({super.key, required this.chatId});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          //써클아바타랑 상대방 이름과의 간격을 설정
          horizontalTitleGap: Sizes.size8,
          contentPadding: EdgeInsets.zero,
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: Sizes.size24,
                child: Text('JH'),
              ),
              Positioned(
                right: -0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border:
                          Border.all(color: Colors.white, width: Sizes.size3)),
                  width: Sizes.size16,
                  height: Sizes.size16,
                ),
              ),
            ],
          ),
          title: Text(
            'JH${widget.chatId}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active Now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FaIcon(FontAwesomeIcons.flag,
                  color: Colors.black, size: Sizes.size20),
              Gaps.h32,
              FaIcon(FontAwesomeIcons.ellipsis,
                  color: Colors.black, size: Sizes.size20),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20, horizontal: Sizes.size14),
            itemBuilder: (context, index) {
              final isMine = index % 2 == 0;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(Sizes.size14),
                    decoration: BoxDecoration(
                      color: isMine ? Colors.blue : Colors.amber,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(Sizes.size20),
                        topRight: const Radius.circular(Sizes.size20),
                        bottomLeft: Radius.circular(isMine ? Sizes.size20 : 0),
                        bottomRight:
                            Radius.circular(!isMine ? Sizes.size20 : 0),
                      ),
                    ),
                    child: const Text(
                      'this is message',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Gaps.v10,
            itemCount: 10,
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.grey.shade50,
              child: Row(
                children: [
                  Gaps.h14,
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      maxLines: null,
                      minLines: null,
                      decoration: InputDecoration(
                        filled: true,
                        //텍스트필드 안에 네모
                        fillColor: Colors.white,
                        //글써지는 네모에 패딩
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size12, vertical: Sizes.size12),

                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.faceSmile,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        hintText: 'Send a message...',
                        border: OutlineInputBorder(
                          //텍스트창 바깥부분 모서리
                          borderRadius: BorderRadius.circular(Sizes.size20),
                          //테두리
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  Container(
                    child: const FaIcon(FontAwesomeIcons.paperPlane),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
