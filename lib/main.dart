import 'package:flutter/material.dart';
import 'package:kill_tiktok/features/inbox/activity_screen.dart';
import 'package:kill_tiktok/features/main_navigation/main_navigation_screen.dart';

import 'constants/sizes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'tiktok killer',
        theme: ThemeData(
          //클릭했을때 스플래시칼라가 없어진다
          //splashColor: Colors.transparent,
          //아예 없어진다 색깔이
          //highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFE9435A),
          textSelectionTheme:
              //쿠퍼티노 텍스트필드는 커서칼라 커스텀이 안되기 때문에 메인 테마설정하는곳에서 한다
              const TextSelectionThemeData(cursorColor: Color(0xFFE9435A)),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const ActivityScreen());
  }
}
