import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';
import 'package:kill_tiktok/features/settings_screen/settings_screen.dart';
import 'package:kill_tiktok/features/users/widgets/persistant_tabbar.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({super.key, required this.username, required this.tab});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  void _onGearPressed() {
Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsScreen(),));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: widget.tab == 'likes'?1:0,
        length: 2,
        //커스텀스크롤뷰 대신에 네스티드스크롤뷰를 사용하면 스크롤뷰 두개가 있는 페이지를 잘 쓸수있다.
        child: NestedScrollView(
          //스크롤뷰의 일환
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              //앱바같지만 스크롤이 가능하다
              SliverAppBar(
                title: Text(widget.username),
                actions: [
                  IconButton(
                    onPressed: _onGearPressed,
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
                        Text(
                          '@${widget.username}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.size18),
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
                        padding:
                            const EdgeInsets.symmetric(vertical: Sizes.size12),
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
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistantTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 20,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //몇개의 콜롬을 가질건지
                  crossAxisCount: 3,
                  //간격은 얼마나 둘것인지
                  crossAxisSpacing: Sizes.size2,
                  mainAxisSpacing: Sizes.size2,
                  childAspectRatio: 9 / 14,
                ),
                itemBuilder: (context, index) => Stack(
                  children: [
                    Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 9 / 14,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/1.jpeg',
                            image:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-17g4GD0tz2O509zGFRQraRj4M46WG_XOqA&usqp=CAU',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const Positioned(
                      bottom: Sizes.size5,
                      left: Sizes.size5,
                      child: Text(
                        '2.3m',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const Center(
                child: Text('page 2'),
              )
            ],
          ),
        ),
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
