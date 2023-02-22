import 'package:flutter/material.dart';
import 'package:kill_tiktok/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;
  final PageController _pageController = PageController();

  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //이미 부의 scaffold 위젯 안에 있어서 또  할필요 없음
    return PageView.builder(
        //자석효과 없어짐
        //pageSnapping: false,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: _itemCount,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) =>
            VideoPost(onVideoFinished: _onVideoFinished));
  }
}
