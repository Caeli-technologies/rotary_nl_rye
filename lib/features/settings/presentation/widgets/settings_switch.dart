// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../../../core/prop.dart';

class SettingsSwitch extends StatefulWidget {
  final bool defaultValue;

  const SettingsSwitch({super.key, required this.defaultValue});

  @override
  _SettingsSwitchState createState() => _SettingsSwitchState(defaultValue);
}

class _SettingsSwitchState extends State<SettingsSwitch> {
  bool val;

  _SettingsSwitchState(this.val);

  void switchBool(bool value) {
    setState(() {
      val = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoSwitch(
      activeColor: Palette.accentColor,
      value: val,
      onChanged: (value) => switchBool(value),
    )
        : Switch(
      activeColor: Palette.accentColor,
      value: val,
      onChanged: (value) => switchBool(value),
    );
  }
}
