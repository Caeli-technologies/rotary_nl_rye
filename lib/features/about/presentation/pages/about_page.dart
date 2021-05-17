import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            "About Us",
            textScaleFactor: 1.7,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: Text("About place holder page"));
  }
}
