import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';

import '../../constants/break_point.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _textEditingController = TextEditingController();
  void _onSearchChanged(String value) {}

  void _onSearchSubmitted(String value) {}

  void _changeTab() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //탭바를 사용하려면 컨트롤러가 있어야하는데 스캐폴드를 컨트롤러로 감싸면서 이 문제를 해결한다
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        //키보드 올라가면 화면 사이즈 바뀌는거 방지,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          //웹에서 화면이 커질때 크기를 제한한다
          title: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Breakpoints.sm),
            child: CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
            ),
          ),
          bottom: TabBar(
            onTap: (value) => _changeTab(),
            //클릭효과 삭제
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            //위젯의 리스트
            tabs: [
              for (var tab in tabs) Text(tab),
            ],
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: Sizes.size16),
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size6, vertical: Sizes.size6),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //몇개의 콜롬을 가질건지
                crossAxisCount: width > Breakpoints.md ? 5 : 2,
                //간격은 얼마나 둘것인지
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 21,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4)),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/1.jpeg',
                          image:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-17g4GD0tz2O509zGFRQraRj4M46WG_XOqA&usqp=CAU',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      '${constraints.maxWidth}this is very long captionthis is very long captionthis is very long captionthis is',
                      style: const TextStyle(
                          fontSize: Sizes.size16 + Sizes.size2,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v8,
                    //화면이 작아지면 콘테이너가 작아짐, 어느정도 커지면 또 작아짐 이게 포인트
                    if (constraints.maxWidth < 200 ||
                        constraints.maxWidth > 250)
                      //아래에있는 모든 텍스트가 같은 스타일로 들어간다 한번에
                      DefaultTextStyle(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqQkJWuqp6vsgOKFQXjzfT3tWrOTlYXTkvYA&usqp=CAU'),
                            ),
                            Gaps.h4,
                            const Expanded(
                              child: Text(
                                'my avatar is goint to asnd vew',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            const Text(
                              '2.5M',
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(tab),
              ),
          ],
        ),
      ),
    );
  }
}
