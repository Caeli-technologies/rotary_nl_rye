import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/contributors_page.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/social.dart';
import 'package:share_plus/share_plus.dart';

import 'counselor_list_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var slider1 = true;
  var slider2 = true;
  var slider3 = true;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
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
                      ? 'Hier mot nog een leuk stukje komen. + de link naar de Apple app store link https://example.com'
                      : 'Hier mot nog een leuk stukje komen. + de link naar de google play store link https://example.com',
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
            // buildNotificationOptionRow(
            //     DemoLocalizations.of(context).trans('new4You'),
            //     Platform.isIOS
            //         ? CupertinoSwitch(
            //             activeColor: Palette.accentColor,
            //             value: slider1,
            //             onChanged: (value) {
            //               setState(() {
            //                 slider1 = value;
            //               });
            //             },
            //           )
            //         : Switch(
            //             activeColor: Palette.accentColor,
            //             value: slider1,
            //             onChanged: (value) {
            //               setState(() {
            //                 slider1 = value;
            //               });
            //             },
            //           )),
            buildAccountOptionRow(context, 'Counselor',
                FontAwesomeIcons.handsHelping, CounselorListPage()),
            //TODO Make Emergency page with contacts
            GestureDetector(
                child: Container(
              padding: EdgeInsets.zero,
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    child: FaIcon(FontAwesomeIcons.firstAid,
                        color: Colors.red[900]),
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Emergency",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red[900],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.red[900]),
                  ],
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Emergency Page"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  "Needs to go to a Emergency page with contact information"),
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
              ),
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
                'App version: ${_packageInfo.version} (${_packageInfo.buildNumber})',
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
