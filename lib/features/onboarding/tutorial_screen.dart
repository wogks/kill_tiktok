import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kill_tiktok/features/main_navigation/main_navigation_screen.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showinPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    //유저가 어느방향으로 드래그 하는지 알수있다
    //print(details);
    if (details.delta.dx > 0) {
      //오른쪽 델타엑스는 엑스축이다.
      setState(() {
        _direction = Direction.right;
      });
    } else {
      //to the left
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showinPage = Page.second;
      });
    } else {
      setState(() {
        _showinPage = Page.first;
      });
    }
  }
  void _onEnterAppTab() {
    Navigator.of(context).pushAndRemoveUntil(
          //predicate가 false를 리턴하면 해당라우트는 삭제된다, 트루면 해당 라우트는 유지된다.

          MaterialPageRoute(
            builder: (context) =>  MainNavigationScreen(),
          ),
          (route) {
            return false;
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //화면을 넘기는 swipe를 pan이라고 한다. 팬업데이트는 드래깅을 할때 한다.
      onPanUpdate: _onPanUpdate,
      //dragging이 끝날때 콜백함수
      onPanEnd: _onPanEnd,
      child: Scaffold(
        //두 컴포넌트 사이에 페이드인 페이드아웃 효과를 줌
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v80,
                  Text(
                    'follow the rules!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Sizes.size40),
                  ),
                  Gaps.v16,
                  Text(
                    'Videos are personalized for you based on what you wath, like, and share.',
                    style: TextStyle(fontSize: Sizes.size20),
                  ),
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v80,
                  Text(
                    'enjoy the ride!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Sizes.size40),
                  ),
                  Gaps.v16,
                  Text(
                    'take care of one anotjer.',
                    style: TextStyle(fontSize: Sizes.size20),
                  ),
                ],
              ),
              //first? second를 보여줄지 결정함
              crossFadeState: _showinPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: Sizes.size24, horizontal: Sizes.size24),
          //hide enter button
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _showinPage == Page.first ? 0 : 1,
            child: CupertinoButton(
              color: Theme.of(context).primaryColor, onPressed: _onEnterAppTab,
              child: const Text('Enter the app!'),),
          ),
        ),
      ),
    );
  }
}


























// import 'package:flutter/material.dart';
// import 'package:kill_tiktok/constants/gaps.dart';

// import '../../constants/sizes.dart';

// class TutorialScreen extends StatefulWidget {
//   const TutorialScreen({super.key});

//   @override
//   State<TutorialScreen> createState() => _TutorialScreenState();
// }

// class _TutorialScreenState extends State<TutorialScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         body: SafeArea(
//           //옆으로 슬라이드 하는 앱
//           //탭바는 탭바컨트롤러가 필요한데 스캐폴드를 디폴트탭바컨트롤러로 감싸주면 된다
//           child: TabBarView(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Gaps.v52,
//                     Text(
//                       'Watch cool videos!',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: Sizes.size40),
//                     ),
//                     Gaps.v16,
//                     Text(
//                       'Videos are personalized for you based on what you wath, like, and share.',
//                       style: TextStyle(fontSize: Sizes.size20),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Gaps.v52,
//                     Text(
//                       'follow the rules!',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: Sizes.size40),
//                     ),
//                     Gaps.v16,
//                     Text(
//                       'Videos are personalized for you based on what you wath, like, and share.',
//                       style: TextStyle(fontSize: Sizes.size20),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Gaps.v52,
//                     Text(
//                       'enjoy the ride!',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: Sizes.size40),
//                     ),
//                     Gaps.v16,
//                     Text(
//                       'Videos are personalized for you based on what you wath, like, and share.',
//                       style: TextStyle(fontSize: Sizes.size20),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: Sizes.size48),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 //페이지 번호, 같은 디폴트탭컨트롤러에 있어야된다
//                 TabPageSelector(
//                   color: Colors.white,
//                   selectedColor: Colors.black38,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
