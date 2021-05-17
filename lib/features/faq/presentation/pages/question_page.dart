// @dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          /*
          leading: Container(
            margin: EdgeInsets.only(left: 10, top: 5),
            width: 40,
            height: 40,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Icon(
                Icons.arrow_back,
                color: Palette.accentColor,
                size: 30.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Palette.themeShadeColor,
              padding: const EdgeInsets.all(5.0),
            ),
          ),
        */
          title: Text(
            DemoLocalizations.of(context).trans('questionTitle'),
            textScaleFactor: 1.4,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          //padding: const EdgeInsets.only(top: 60),
          children: [
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
        ));
  }
}
