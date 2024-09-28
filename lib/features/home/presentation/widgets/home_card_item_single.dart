// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class HomeCardItemSingle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget pushTo;

  HomeCardItemSingle({
    required this.title,
    required this.icon,
    required this.pushTo,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          boxShadow: [kSubtleBoxShadow],
        ),
        child: MaterialButton(
          elevation: 0,
          highlightElevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pushTo),
            );
          },
          color: Palette.themeCardShadeColor,
          height: 80,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: FaIcon(
                      icon,
                      color: Palette.lightIndigo,
                      size: 35,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, color: Palette.indigo),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
