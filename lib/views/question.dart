// @dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 60),
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Vragen?',
              textScaleFactor: 2.4,
              style: TextStyle(
                  color: Color.fromRGBO(19, 33, 70, 1),
                  fontWeight: FontWeight.bold),
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
