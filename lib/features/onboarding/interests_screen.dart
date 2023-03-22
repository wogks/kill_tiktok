import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/features/onboarding/tutorial_screen.dart';
import 'package:kill_tiktok/features/onboarding/widgets/interst_button.dart';

class InterestScreen extends StatefulWidget {
  static const String routeName = 'interests';
  static const String routeURL = '/tutorial';

  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

final _scrollController = ScrollController();

class _InterestScreenState extends State<InterestScreen> {
  bool _showTitle = false;

  void _onNextTap() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const TutorialScreen()));
  }

  void _onScroll() {
    //offset은 얼마나 스크롤했는지 알려준다
    if (_scrollController.offset > 127) {
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //움직임에 따라서 투명도를 조절한다.
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: const Text('Choose your interests'),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(
                left: Sizes.size24,
                right: Sizes.size24,
                bottom: Sizes.size16,
                top: Sizes.size16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  'Choose your interests',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: Sizes.size40),
                ),
                Gaps.v20,
                const Text(
                  'Get better video recomendations',
                  style: TextStyle(fontSize: Sizes.size20),
                ),
                Gaps.v64,
                //가로로 배치
                Wrap(
                  //세로간격
                  runSpacing: 20,
                  //가로간격
                  spacing: 20,
                  children: [
                    for (var interests in interests)
                      InterestButton(interests: interests),
                  ],
                ),
                Gaps.v64,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size40,
            top: Sizes.size16,
            left: Sizes.size24,
            right: Sizes.size24,
          ),
          child: CupertinoButton(
            onPressed: () {
              _onNextTap();
            },
            color: Theme.of(context).primaryColor,
            child: const Text('NEXT'),
          ),
          // child: Container(
          //   padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).primaryColor,
          //   ),
          //   child: const Text(
          //     'Next',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(color: Colors.white, fontSize: Sizes.size16),
          //   ),
          // ),
        ),
      ),
    );
  }
}

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];
