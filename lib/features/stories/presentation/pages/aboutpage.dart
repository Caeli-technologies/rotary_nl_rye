// @dart=2.9
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:rotary_nl_rye/features/stories/data/datasources/languages.dart';
import 'package:rotary_nl_rye/core/prop.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

//TODO needs to look like the story page. nut then only for contacts of the organication and Rotex (https://rotex.org/who-we-are/)

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
              'About page. still needs a name',
              textScaleFactor: 2.4,
              style:
                  TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromRGBO(70, 197, 212, 1), //fill the image still needs to chagnge
                  ),
                  child: Image.asset(
                    'assets/image/1.PNG',
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              title: Text('test',
                  style: TextStyle(
                    color: Palette.indigo,
                  )),
              subtitle: Text(
                'test',
                style: TextStyle(
                  color: Palette.indigo,
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Palette.indigo,
              ),
            ),
          )
        ],
      ),
    );
  }
}
