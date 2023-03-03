// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          SwitchListTile(value: _notifications, onChanged: _onNoificationsChanged,
          title: const Text('r가능하면 섭타이틀이랑 이거써라'),),
          //Switch.adaptive 폰에따라 바뀜
          CupertinoSwitch(value: _notifications, onChanged: _onNoificationsChanged),
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
          const AboutListTile()
        ],
      ),
    );
  }
}
