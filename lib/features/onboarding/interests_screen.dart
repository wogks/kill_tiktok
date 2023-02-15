import 'package:flutter/material.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';

class InterestScreen extends StatelessWidget {
  const InterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your interests'),
      ),
      body: SingleChildScrollView(
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size12,
                        horizontal: Sizes.size24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Sizes.size32),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Text(
                        interests,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
              Gaps.v64,
            ],
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
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Next',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: Sizes.size16),
            ),
          ),
        ),
      ),
    );
  }
}
