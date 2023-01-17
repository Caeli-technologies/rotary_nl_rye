// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class CardItem extends StatefulWidget {
  final Widget title;
  final Widget icon;
  final Widget pushTo;
  final int? notificationCount;

  CardItem(
      {required this.title,
      required this.icon,
      required this.pushTo,
      this.notificationCount});

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<CardItem> {
  bool _showBade = false;

  void pushToPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget.pushTo),
    );
  }

  void checkForNotifications() {
    if (widget.notificationCount != null && widget.notificationCount! > 0) {
      setState(() {
        _showBade = true;
      });
    } else {
      setState(() {
        _showBade = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkForNotifications();

    return Container(
      decoration: BoxDecoration(
        boxShadow: [kSubtleBoxShadow],
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: MaterialButton(
        onPressed: () => pushToPage(context),
        color: Palette.themeCardShadeColor,
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
                  //margin: EdgeInsets.only(bottom: 16),
                  child: badges.Badge(
                      showBadge: _showBade,
                      position: badges.BadgePosition.topEnd(top: -15, end: -15),
                      badgeContent: Text(
                        widget.notificationCount.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      child: widget.icon),
                ),
                SizedBox(
                  height: 10,
                ),
                widget.title
              ],
            )
          ],
        ),
      ),
    );
  }
}
