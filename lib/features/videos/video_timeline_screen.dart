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
    return;
    //다음페이지로 넘어가틑 메서드
    // ignore: dead_code
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

  Future<void> _onRefresh()async{
    //원래 api자리
    return Future.delayed(const Duration(seconds: 2));

  }

  @override
  Widget build(BuildContext context) {
    //이미 부의 scaffold 위젯 안에 있어서 또  할필요 없음
    return RefreshIndicator(
      //당겨서 새로고침 기능 반드시 퓨처를 반환해야한다
      onRefresh: _onRefresh,
      //위치조정
      displacement: 40,
      edgeOffset: 10,
      color: Theme.of(context).primaryColor,
      child: PageView.builder(
          //자석효과 없어짐
          //pageSnapping: false,
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemCount: _itemCount,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) =>
              VideoPost(onVideoFinished: _onVideoFinished,
              index: index),),
    );
  }
}
