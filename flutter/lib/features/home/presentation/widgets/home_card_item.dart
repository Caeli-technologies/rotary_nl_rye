// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class HomeCardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget pushTo;

  HomeCardItem({
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
          boxShadow: [kSubtleBoxShadow],
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pushTo),
            );
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
                  Container(
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
  final Widget pushTo;

  HomeCardItemToNL({
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
          boxShadow: [kSubtleBoxShadow],
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pushTo),
            );
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
                  Container(
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
