// @dart=2.9
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_version/get_version.dart';
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/contributors_page.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/social.dart';
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
              Share.share(
                  Platform.isIOS
                      ? 'Apple app store link https://example.com'
                      : 'android play store link https://example.com',
                  subject: 'look at this nice app :)');
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
                context,
                DemoLocalizations.of(context).trans('social'),
                FontAwesomeIcons.hashtag,
                SocialPage()),
            buildAccountOptionRow(
                context,
                DemoLocalizations.of(context).trans('privacyAndSecurity'),
                FontAwesomeIcons.shieldAlt,
                null),
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
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
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
            GestureDetector(
                child: Container(
              padding: EdgeInsets.zero,
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    child: FaIcon(
                      FontAwesomeIcons.code,
                      color: Palette.lightIndigo,
                    ),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContributorsPage()),
                  );
                },
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'App version: $_projectVersion ($_projectCode)',
                style: TextStyle(color: Color(0xFF777777)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildNotificationOptionRow(String title, Widget aSwitch) {
    return Container(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            child: FaIcon(
              FontAwesomeIcons.bell,
              color: Palette.lightIndigo,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Palette.grey,
              ),
            ),
            Transform.scale(scale: 1, child: aSwitch)
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(
    BuildContext context,
    String title,
    IconData icon,
    pushTo,
  ) {
    return GestureDetector(
        child: Container(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            child: FaIcon(
              icon,
              color: Palette.lightIndigo,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
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
        /*
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
*/
        onTap: () {
          if (pushTo != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pushTo),
            );
          }
        },
      ),
    ));
  }
}
