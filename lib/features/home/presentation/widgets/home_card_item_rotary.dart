import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class HomeCardItemSingleRotary extends StatelessWidget {
  final String title, description;
  // final icon;
  final int currentNewsIndex;
  final pushTo;

  HomeCardItemSingleRotary(
      {required this.title,
      // required this.icon,
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
          borderRadius: BorderRadius.circular(kBorderRadius),
          boxShadow: [kSubtleBoxShadow],
        ),
        child: MaterialButton(
          elevation: 0,
          highlightElevation: 0,
          onPressed: () {
            if (pushTo != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pushTo),
              );
            }
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
                    child: SvgPicture.asset(
                        'assets/icons/custom/rotary-logo-icon.svg',
                        // color: Color(0xFFf7a81b),
                        color: Palette.lightIndigo,
                        height: 35),
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
