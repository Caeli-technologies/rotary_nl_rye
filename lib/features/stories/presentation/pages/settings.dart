// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var slider1 = true;
  var slider2 = true;
  var slider3 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(left: 16, top: 60, right: 16),
          children: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Text(
                DemoLocalizations.of(context).trans('settingsTitle'),
                textScaleFactor: 2.4,
                style: TextStyle(
                    color: Palette.indigo, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Palette.accentColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  DemoLocalizations.of(context).trans('account'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(
                context, DemoLocalizations.of(context).trans('social')),
            buildAccountOptionRow(
                context, DemoLocalizations.of(context).trans('language')),
            buildAccountOptionRow(context,
                DemoLocalizations.of(context).trans('privacyAndSecurity')),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Palette.accentColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  DemoLocalizations.of(context).trans('notifications'),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow(
                DemoLocalizations.of(context).trans('new4You'),
                Platform.isIOS
                    ? CupertinoSwitch(
                        activeColor: Palette.accentColor,
                        value: slider1,
                        onChanged: (value) {
                          setState(() {
                            slider1 = value;
                          });
                        },
                      )
                    : Switch(
                        activeColor: Palette.accentColor,
                        value: slider1,
                        onChanged: (value) {
                          setState(() {
                            slider1 = value;
                          });
                        },
                      )),
            buildNotificationOptionRow(
                DemoLocalizations.of(context).trans('accountActivity'),
                Platform.isIOS
                    ? CupertinoSwitch(
                        activeColor: Palette.accentColor,
                        value: slider2,
                        onChanged: (value) {
                          setState(() {
                            slider2 = value;
                          });
                        },
                      )
                    : Switch(
                        activeColor: Palette.accentColor,
                        value: slider2,
                        onChanged: (value) {
                          setState(() {
                            slider2 = value;
                          });
                        },
                      )),
            buildNotificationOptionRow(
                DemoLocalizations.of(context).trans('opportunity'),
                Platform.isIOS
                    ? CupertinoSwitch(
                        activeColor: Palette.accentColor,
                        value: slider3,
                        onChanged: (value) {
                          setState(() {
                            slider3 = value;
                          });
                        },
                      )
                    : Switch(
                        activeColor: Palette.accentColor,
                        value: slider3,
                        onChanged: (value) {
                          setState(() {
                            slider3 = value;
                          });
                        },
                      )),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, Widget aSwitch) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Palette.grey),
        ),
        Transform.scale(scale: 0.7, child: aSwitch)
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Palette.grey,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Palette.grey,
            ),
          ],
        ),
      ),
    );
  }
}
