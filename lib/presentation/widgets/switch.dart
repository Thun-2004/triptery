import 'package:flutter/material.dart';

class ToggleSwitch extends StatefulWidget {
  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Switch(
          value: isOn,
          onChanged: (bool newValue) {
            setState(() {
              isOn = newValue;
            });
          },
          activeColor: Color(0xFF22C55E), // green color from your image
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey.shade400,
        ),
      ),
    );
  }
}