import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
              );

              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print(date);
              print(time);

              final booking = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    child: child!,
                    data: ThemeData(
                        appBarTheme: AppBarTheme(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    )),
                  );
                },
              );
              print(booking);
            },
            title: Text('What is your birthday?'),
          ),
          AboutListTile()
        ],
      ),
    );
  }
}
