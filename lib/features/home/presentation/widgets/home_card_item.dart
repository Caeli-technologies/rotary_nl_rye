// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class HomeCardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int currentNewsIndex;
  final pushTo;

  HomeCardItem(
      {required this.title,
      required this.icon,
      this.pushTo,
      required this.currentNewsIndex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
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
                          child: badges.Badge(
                            position:
                                badges.BadgePosition.topEnd(top: -15, end: -15),
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

                  SizedBox(
                      width: 80,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Palette.indigo,
                        ),
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      )),

                  // Text(
                  //   title,
                  //   style: TextStyle(fontSize: 14, color: Palette.indigo),
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class HomeCardItemToNL extends StatelessWidget {
  final String title;
  final IconData icon;
  final int currentNewsIndex;
  final pushTo;

  HomeCardItemToNL(
      {required this.title,
      required this.icon,
      this.pushTo,
      required this.currentNewsIndex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
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
                          child: badges.Badge(
                            position:
                                badges.BadgePosition.topEnd(top: -15, end: -15),
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
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Palette.indigo,
                        ),
                      ),
                      // airplain
                      FaIcon(
                        FontAwesomeIcons.arrowRightLong,
                        color: Palette.lightIndigo,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // NL
                      SvgPicture.asset(
                        'assets/icons/flags/nl.svg',
                        height: 15,
                        width: 15,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
