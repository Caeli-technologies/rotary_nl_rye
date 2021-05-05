// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/languages.dart';
import 'package:rotary_nl_rye/main.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
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
                DemoLocalizations.of(context).trans('new4You'), true),
            buildNotificationOptionRow(
                DemoLocalizations.of(context).trans('accountActivity'), true),
            buildNotificationOptionRow(
                DemoLocalizations.of(context).trans('opportunity'), false),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Palette.grey),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              activeColor: Palette.accentColor,
              onChanged: (bool val) {},
            ))
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
