import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        //스크롤뷰의 일환
        slivers: [
          //앱바같지만 스크롤이 가능하다
          SliverAppBar(
            title: const Text('wogks27'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.gear,
                  size: Sizes.size20,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  foregroundColor: Colors.amber,
                  child: Text('JH'),
                ),
                Gaps.v20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '@재한',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: Sizes.size18),
                    ),
                    Gaps.h5,
                    FaIcon(FontAwesomeIcons.solidCircleCheck,
                        color: Colors.blue.shade500, size: Sizes.size16),
                  ],
                ),
                Gaps.v24,
                SizedBox(
                  height: Sizes.size44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            '10M',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size18,
                            ),
                          ),
                          Gaps.v3,
                          Text(
                            'Follwers',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        //부모 위젯에 높이가 있어야된다. 그래서 로우에 사이즈드 박스를 감싼후 높이를 지정해준다
                        width: Sizes.size32,
                        thickness: Sizes.size1,
                        color: Colors.grey.shade400,
                        //선을 짧게 해준다
                        indent: Sizes.size14,
                        endIndent: Sizes.size14,
                      ),
                      Column(
                        children: [
                          const Text(
                            '194.3M',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size18,
                            ),
                          ),
                          Gaps.v3,
                          Text(
                            'Likes',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        //부모 위젯에 높이가 있어야된다. 그래서 로우에 사이즈드 박스를 감싼후 높이를 지정해준다
                        width: Sizes.size32,
                        thickness: Sizes.size1,
                        color: Colors.grey.shade400,
                        //선을 짧게 해준다
                        indent: Sizes.size14,
                        endIndent: Sizes.size14,
                      ),
                      Column(
                        children: [
                          const Text(
                            '97',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size18,
                            ),
                          ),
                          Gaps.v3,
                          Text(
                            'Follwing',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gaps.v14,
                //프렉셔널리사이즈드 박스는 아버지의 너비와 높이에 의존해서 너비와 높이를 가진다
                FractionallySizedBox(
                  widthFactor: 0.33,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size4),
                        color: Theme.of(context).primaryColor),
                    child: const Text(
                      'Follow',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Gaps.v14,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                  child: Text(
                    'all asdjoi asjdiojw jpoajsd wjpdaoskj ansiodjwio asjdoiasjdiojw jpoajsd jwio asjdoi',
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.v14,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(FontAwesomeIcons.link, size: Sizes.size12),
                    Gaps.h4,
                    Text(
                      'My wogkseu@naver.co',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Gaps.v20,
                //탭바는 항상 컨트롤러가 있어야 하기 때문에 가장 부모의 위젯을 디폴트텝바컨트롤라로 싸야한다
                Container(
                  decoration: BoxDecoration(
                      //탭바 위아래 선 두줄
                      border: Border.symmetric(
                    horizontal:
                        BorderSide(color: Colors.grey.shade200, width: 0.5),
                  )),
                  child: const TabBar(
                    indicatorColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.symmetric(vertical: Sizes.size10),
                    labelColor: Colors.black,
                    tabs: [
                      Padding(
                        //인디케이터 길이를 늘리기위해 라벨에 패딩을 먹인다
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Icon(Icons.grid_4x4_rounded),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: FaIcon(FontAwesomeIcons.heart),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class CustomDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.indigo,
//       //부모로부터 최대한 많은 공간을 차지한다
//       child: const FractionallySizedBox(
//         // 1=모든부분 차지
//         heightFactor: 1,
//         child: Center(
//           child: Text(
//             'title!!',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   //보통때 크기
//   double get maxExtent => 100;

//   @override
//   //화면 내려갔을때 위에 고정되는 크기
//   double get minExtent => 80;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }


//slivers:[]안에 들어가는것들
//         SliverAppBar(
//           //살짝만 내려도 앱바 전체가 내려온다 쿵!
//           //  snap: true,
//           //밑으로 당기면 앱바가 보임
//           // floating: true,
//           //밑으로 당기면 늘어난다
//           stretch: true,
//           //앱바를 고정한다
//           pinned: true,
//           backgroundColor: Colors.amber,
//           //80까지 줄어들수 있고 으 이후에는 타이틀이 사라진다
//           collapsedHeight: 80,
//           expandedHeight: 200,
//           flexibleSpace: FlexibleSpaceBar(
//             stretchModes: const [
//               StretchMode.blurBackground,
//               //StretchMode.fadeTitle,
//               StretchMode.zoomBackground
//             ],
//             background: Image.asset(
//               'assets/images/1.jpeg',
//               fit: BoxFit.cover,
//             ),
//             title: const Text('hello'),
//           ),
//         ),
//         //일반적인 플러터 위젯을 sliver안에 넣을때 사용할떄 이걸 쓴다
//         SliverToBoxAdapter(
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: 25,
//                 backgroundColor: Colors.red,
//               )
//             ],
//           ),
//         ),
//         SliverFixedExtentList(
//           delegate: SliverChildBuilderDelegate(
//             //아이템카운트 느낌
//             childCount: 50,
//             (context, index) => Container(
//               color: Colors.amber[100 * (index % 9)],
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Text('$index'),
//               ),
//             ),
//           ),
//           //유닛들의 높이
//           itemExtent: 100,
//         ),
//         SliverPersistentHeader(
//           pinned: true,
//           delegate: CustomDelegate(),
//         ),
//         SliverGrid(
//           delegate: SliverChildBuilderDelegate(
//             childCount: 50,
//             (context, index) => Container(
//               color: Colors.blue[100 * (index % 9)],
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Text('$index'),
//               ),
//             ),
//           ),
//           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//             //그리드의 높이
//             maxCrossAxisExtent: 100,
//             mainAxisSpacing: Sizes.size10,
//             crossAxisSpacing: Sizes.size10,
//             //사각형의 비율
//             childAspectRatio: 1,
//           ),
//         ),
