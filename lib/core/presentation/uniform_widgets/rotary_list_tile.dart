// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../prop.dart';

// 📦 Package imports:


class RotaryListTile extends StatelessWidget {
  final GestureTapCallback? action;
  final String title;
  final String? subtitle;
  final Widget leading;

  const RotaryListTile(
      {required this.action,
      required this.title,
      this.subtitle,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: action,
      contentPadding: EdgeInsets.all(0),
      leading: leading,
      title: Text(title,
          style: TextStyle(
            color: Palette.indigo,
            fontWeight: FontWeight.w600,
          )),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Palette.grey,
              ),
            )
          : null,
      trailing: Icon(
        Icons.keyboard_arrow_right,
        size: 30,
        color: Palette.indigo,
      ),
    );
  }
}
