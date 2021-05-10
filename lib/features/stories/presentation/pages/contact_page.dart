// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

//TODO needs to look like the story page. nut then only for contacts of the organication and Rotex (https://rotex.org/who-we-are/)

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 60),
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Contact List',
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
                    color: Palette
                        .imageBackgroundColor, //fill the image still needs to chagnge
                  ),
                  child: Image.asset(
                    'assets/image/1.PNG',
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              title: Text('Ruben Talstra',
                  style: TextStyle(
                    color: Palette.indigo,
                  )),
              subtitle: Text(
                'My fuction XD is a Dev i think',
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