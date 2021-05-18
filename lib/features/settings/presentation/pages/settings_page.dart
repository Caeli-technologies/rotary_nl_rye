// @dart=2.9
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_version/get_version.dart';
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/contributors_page.dart';
import 'package:share/share.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var slider1 = true;
  var slider2 = true;
  var slider3 = true;

  String _platformVersion = 'Unknown';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get build number.';
    }

    String projectAppID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectAppID = await GetVersion.appID;
    } on PlatformException {
      projectAppID = 'Failed to get app ID.';
    }

    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectName = await GetVersion.appName;
    } on PlatformException {
      projectName = 'Failed to get app name.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          DemoLocalizations.of(context).trans('settingsTitle'),
          textScaleFactor: 1.7,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              CupertinoIcons.share,
              color: Palette.indigo,
            ),
            onPressed: () {
              Share.share('check out my website https://example.com',
                  subject: 'Look what I made!');
            },
          )
        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(left: 16, top: 15, right: 16),
          children: [
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
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.code,
                  color: Palette.accentColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Development",
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContributorsPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Contributors",
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
            ),
            Text(
              'App version: $_projectVersion ($_projectCode)',
              style: TextStyle(color: Color(0xFF777777)),
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
