import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kill_tiktok/common/widgets/video_configureation/video_config.dart';
import 'package:kill_tiktok/router.dart';

import 'constants/sizes.dart';

void main() async {
  //플러터 엔진과 프레임워크, 플랫폼을 묶는 접착제 안드와 애플은 다른 환경이다. 통신을 위해 안정성을 보장해야 하는데
  WidgetsFlutterBinding.ensureInitialized();
  //화면 눕히는거 금지시키는법
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // 상태표시줄 색 바꿔주는법 원하는 페이지에만 사용할수있다
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.light
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return VideoConfig(
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'tiktok killer',
        //폰의 기기가 다크모드면 앱도 다크모드로 변한다
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
            bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade800),
            scaffoldBackgroundColor: Colors.black,
            primaryColor: const Color(0xFFE9435A),
            brightness: Brightness.dark),
        theme: ThemeData(
          textTheme: const TextTheme(
              headlineLarge: TextStyle(
            fontSize: Sizes.size24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          )),
          bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade50),
          brightness: Brightness.light,
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
      ),
    );
  }
}
