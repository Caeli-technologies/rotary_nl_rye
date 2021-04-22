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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 60),
        children: [
          ExpansionTile(
            leading: Icon(FontAwesomeIcons.sign),
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
            leading: Icon(FontAwesomeIcons.sign),
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
