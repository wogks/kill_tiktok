import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  const VideoPost({super.key, required this.onVideoFinished});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/video.mp4');

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      //비디오 플레이어의 길이가 사용자가 보고있는 화면의 위치와 같다면(10초짜리 영상에 10초에 다다르면)
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished;
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    _videoPlayerController.play();
    setState(() {});
    //비디오 플레이가 끝나면 실행될 함수
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //화면 전체를 채우는 위젯
        Positioned.fill(
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  color: Colors.amber,
                ),
        ),
      ],
    );
  }
}
