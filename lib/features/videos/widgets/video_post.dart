import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({super.key});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //화면 전체를 채우는 위젯
        Positioned.fill(child: Container(
          color: Colors.amber,
        ))
      ],
    );
  }
}