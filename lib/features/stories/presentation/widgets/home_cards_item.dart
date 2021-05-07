import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class HomeCardsItem extends StatelessWidget {
  final String title, description;
  final IconData icon;

  HomeCardsItem(
      {required this.title,
      required this.icon,
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
                        icon,
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
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(description),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close")),
              ],
            );
          }))
    );
  }
}
