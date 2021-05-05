// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:rotary_nl_rye/features/stories/data/datasources/languages.dart';
import 'package:rotary_nl_rye/core/prop.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 60),
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'About List (not sure)',
              textScaleFactor: 2.4,
              style:
                  TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ExpansionTile(
            leading: Icon(FontAwesomeIcons.question),
            title: Text("Expansion Title"),
            subtitle: Text("  Sub Title's"),
            children: <Widget>[
              Text(
                "In Children use can use any flutter Widget",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                    "Children Widgets are expanded/ visible when Expansion Tile Widget is Clicked"),
              )
            ],
          ),
          ExpansionTile(
            leading: Icon(FontAwesomeIcons.question),
            title: Text("Expansion Title"),
            subtitle: Text("  Sub Title's"),
            children: <Widget>[
              Text(
                "In Children use can use any flutter Widget",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                    "Children Widgets are expanded/ visible when Expansion Tile Widget is Clicked"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
