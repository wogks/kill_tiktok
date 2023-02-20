import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;
  final PageController _pageController = PageController();

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.teal,
    Colors.amber,
  ];

  void _onPageChanged(int page) {
     _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 20),
        curve: Curves.linear,
      );
    if (page == _itemCount - 1) {
     
      _itemCount = _itemCount + 4;
      colors.addAll([
        Colors.blue,
        Colors.red,
        Colors.teal,
        Colors.amber,
      ]);
      setState(() {});
    }
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
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text('$index'),
        ),
      ),
    );
  }
}
