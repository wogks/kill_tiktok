// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kill_tiktok/common/widgets/video_configureation/video_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNoificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ValueListenableBuilder(
            valueListenable: videoConfig,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: value,
              onChanged: (value) {
                videoConfig.value = !videoConfig.value;
              },
              title: const Text('automute videos'),
              subtitle: const Text('video will be muted by default'),
            ),
          ),
          SwitchListTile(
            value: _notifications,
            onChanged: _onNoificationsChanged,
            title: const Text('r가능하면 섭타이틀이랑 이거써라'),
          ),
          //Switch.adaptive 폰에따라 바뀜
          CupertinoSwitch(
              value: _notifications, onChanged: _onNoificationsChanged),
          Checkbox(value: _notifications, onChanged: _onNoificationsChanged),
          Switch(value: _notifications, onChanged: _onNoificationsChanged),
          CheckboxListTile(
            checkColor: Colors.amber,
            activeColor: Colors.black,
            value: _notifications,
            onChanged: _onNoificationsChanged,
            title: const Text('Enable notifications'),
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
              );

              // ignore: use_build_context_synchronously
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print(date);
              print(time);

              // ignore: use_build_context_synchronously
              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                        appBarTheme: const AppBarTheme(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    )),
                    child: child!,
                  );
                },
              );
              print(booking);
            },
            title: const Text('What is your birthday?'),
          ),
          ListTile(
            title: const Text('log out (IOS)'),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('r u sure?'),
                  content: const Text('please dont go'),
                  actions: [
                    CupertinoDialogAction(
                        child: const Text('no'),
                        //새로운 창을 푸시한 상태라서 팝을 해준다
                        onPressed: () => Navigator.of(context).pop()),
                    CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        //빠ㄹ간색
                        isDestructiveAction: true,
                        child: const Text('yes')),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('log out (Android)'),
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const FaIcon(FontAwesomeIcons.skull),
                  title: const Text('r u sure?'),
                  content: const Text('please dont go'),
                  actions: [
                    IconButton(
                        icon: const FaIcon(FontAwesomeIcons.car),
                        //새로운 창을 푸시한 상태라서 팝을 해준다
                        onPressed: () => Navigator.of(context).pop()),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('yes')),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('log out (IOS/Bottom)'),
            textColor: Colors.red,
            onTap: () {
              //밑에서 튀어나오고 다른곳을 누르면 없어진다
              showCupertinoModalPopup(
                context: context,
                //마테리얼의 그냥 alert dialog를 함께 사용해도 된다
                builder: (context) => CupertinoActionSheet(
                  title: const Text('r u sure?'),
                  message: const Text('plz dont ggoogogogo'),
                  actions: [
                    CupertinoActionSheetAction(
                        //더 굵게 나온다
                        isDefaultAction: true,
                        child: const Text('no'),
                        //새로운 창을 푸시한 상태라서 팝을 해준다
                        onPressed: () => Navigator.of(context).pop()),
                    CupertinoActionSheetAction(
                        onPressed: () => Navigator.of(context).pop(),
                        //빠ㄹ간색
                        isDestructiveAction: true,
                        child: const Text('yes')),
                  ],
                ),
              );
            },
          ),
          const AboutListTile(
            applicationVersion: '1.0',
            applicationLegalese: 'dont copyme',
          )
        ],
      ),
    );
  }
}
