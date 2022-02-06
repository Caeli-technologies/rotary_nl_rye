import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:badges/badges.dart';

class HomeCardItem extends StatelessWidget {
  final String title, description;
  final IconData icon;
  final int currentNewsIndex;
  final pushTo;

  HomeCardItem(
      {required this.title,
      required this.icon,
      required this.description,
      this.pushTo,
      required this.currentNewsIndex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [kSubtleBoxShadow],
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: MaterialButton(
          onPressed: () {
            if (pushTo != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pushTo),
              );
            }
          },
          color: Palette.themeCardShadeColor,
          height: 120,
          elevation: 0,
          highlightElevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius)),
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
                            position: BadgePosition.topEnd(top: -15, end: -15),
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
                          margin: EdgeInsets.only(bottom: 16),
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
