// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletons/skeletons.dart';

// 🌎 Project imports:
import '../../../../core/lang/languages.dart';
import '../../../../core/prop.dart';

class SettingsOption extends StatelessWidget {
  final Function? action;
  final IconData leadingIcon;
  final Widget trailing;
  final String title;

  const SettingsOption({
    Key? key,
    this.action,
    required this.leadingIcon,
    required this.title,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: FaIcon(
          leadingIcon,
          color: Palette.indigo,
        ),
        title: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Palette.grey,
                    ),
                  ),
                  trailing,
                ],
              ),
            ],
          ),
        ),
        onTap: () => action != null ? action!() : null,
      ),
    );
  }
}
