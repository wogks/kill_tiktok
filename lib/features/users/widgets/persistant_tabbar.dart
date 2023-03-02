import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/sizes.dart';

class PersistantTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return //탭바는 항상 컨트롤러가 있어야 하기 때문에 가장 부모의 위젯을 디폴트텝바컨트롤라로 싸야한다
        Container(
      decoration: BoxDecoration(
        color: Colors.white,
        //탭바 위아래 선 두줄
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
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
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
