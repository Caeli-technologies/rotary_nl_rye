import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:badges/badges.dart';

class HomeCardItemSingle extends StatelessWidget {
  final String title, description;
  final IconData icon;
  final int currentNewsIndex;
  final pushTo;

  HomeCardItemSingle(
      {required this.title,
      required this.icon,
      required this.description,
      this.pushTo,
      required this.currentNewsIndex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 80,
              decoration: BoxDecoration(
                color: Palette.themeCardShadeColor,
                boxShadow: [kSubtleBoxShadow],
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      icon == FontAwesomeIcons.newspaper && currentNewsIndex > 0
                          ? Container(
                              margin: EdgeInsets.only(bottom: 16),
                              child: Badge(
                                position:
                                    BadgePosition.topEnd(top: -15, end: -15),
                                badgeContent: Text(currentNewsIndex.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                child: FaIcon(
                                  icon,
                                  color: Palette.lightIndigo,
                                  size: 35,
                                ),
                              ))
                          : Container(
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
            onTap: () {
              if (pushTo != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pushTo),
                );
              }
            }));
  }
}
