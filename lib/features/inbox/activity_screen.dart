import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/constants/gaps.dart';
import 'package:kill_tiktok/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
//tick은 애니메이션의 매 프레인마다 콜백 함수를 호출
    with
        SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(20, (index) => '${index}h');

//late여야한다 이닛스테이트같은 초기화문에서도 this를 참조할수 있다 this나 다른 인스턴스를 참조하려면 late를 써야한다
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));
  late final Animation<double> _animation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  void _onDismissed(String notification) {
    //옆으로 슬라이드할때 진짜로 지우는 메서드
    _notifications.remove(notification);
    setState(() {});
  }

  void _ontitleTab() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _ontitleTab,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('All Activity'),
              Gaps.h5,
              //
              RotationTransition(
                turns: _animation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Gaps.v14,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'New',
              style: TextStyle(
                  fontSize: Sizes.size14, color: Colors.grey.shade500),
            ),
          ),
          Gaps.v14,
          for (var notification in _notifications)
            //밀어서 삭제
            Dismissible(
              onDismissed: (direction) => _onDismissed(notification),
              key: Key(notification),
              background: Container(
                //아이콘 위치
                alignment: Alignment.centerLeft,
                color: Colors.amber,
                child: const Padding(
                  padding: EdgeInsets.only(left: Sizes.size10),
                  child: FaIcon(FontAwesomeIcons.check,
                      color: Colors.white, size: Sizes.size32),
                ),
              ),
              secondaryBackground: Container(
                //아이콘 위치
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.only(right: Sizes.size10),
                  child: FaIcon(FontAwesomeIcons.trashCan,
                      color: Colors.white, size: Sizes.size32),
                ),
              ),
              child: ListTile(
                minVerticalPadding: Sizes.size16,
                //padding of listile
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: Sizes.size10),
                leading: Container(
                  width: Sizes.size52,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.shade400, width: Sizes.size1),
                      shape: BoxShape.circle,
                      color: Colors.white),
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.bell,
                    color: Colors.black,
                  )),
                ),
                title: RichText(
                  text: TextSpan(
                    text: 'Account updates:',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: Sizes.size16),
                    children: [
                      const TextSpan(
                        text: " upload longer viddeos",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: notification,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
