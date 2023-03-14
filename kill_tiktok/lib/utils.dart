import 'package:flutter/cupertino.dart';
//만약에 칼라를 이렇게 따로 설정했다면 미디어쿼리를 이용한다
bool isDarkMode(BuildContext context) => MediaQuery.of(context).platformBrightness
==Brightness.dark;