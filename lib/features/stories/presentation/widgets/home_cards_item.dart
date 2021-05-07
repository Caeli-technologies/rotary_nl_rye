import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class HomeCardsItem extends StatelessWidget {
  final String picturePath, iconHome, title, description;

  HomeCardsItem(
      {required this.picturePath,
      required this.title,
      required this.iconHome,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 5, right: 5),
          height: 120,
          decoration: BoxDecoration(
            color: Palette.themeCardShadeColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: FaIcon(
                        FontAwesomeIcons.plane,
                        color: Palette.lightIndigo,
                        size: 35,
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, color: Palette.indigo),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () => print(description),
      ),
    );
  }
}
