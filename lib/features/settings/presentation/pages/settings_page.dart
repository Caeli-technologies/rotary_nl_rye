// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/photo_gallery/gallery_view.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/contributors_page.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/social.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitchedFT = false;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  initState() {
    super.initState();
    _initPackageInfo();
    getSwitchValues();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  getSwitchValues() async {
    isSwitchedFT = (await getSwitchState())!;
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('autoInitializeState', value);
    print('Switch Value saved $value');
    return prefs.setBool('autoInitializeState', value);
  }

  Future<bool?> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool('autoInitializeState') ?? false;
    print(isSwitchedFT);

    return isSwitchedFT;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        systemOverlayStyle:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          DemoLocalizations.of(context)!.trans('settingsTitle'),
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
                      ? 'https://apps.apple.com/app/rotary-youth-exchange-nl/id1567096118'
                      : 'https://play.google.com/store/apps/details?id=com.caelitechnologies.rotary_nl_rye',
                  subject: 'look at this nice app :)');
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16, top: 15, right: 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              DemoLocalizations.of(context)!.trans('account'),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: kSecondaryBgColor,
                borderRadius: BorderRadius.circular(kBorderRadius),
                boxShadow: [kBoxShadow]),
            child: Column(
              children: [
                //TODO maybe add later a "Auto load video's on cellular" Switch
                buildAccountOptionRow(context, 'Pictures',
                    FontAwesomeIcons.images, GalleryViewPage()),
                // buildAccountOptionRow(
                //   context,
                //   'Bestuur / Team RYE',
                //   FontAwesomeIcons.users,
                //   PDFPageWithShare(
                //     pdfUrl:
                //         'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/pdf/r.i.-multidistrict-youth-exchange-program-the-netherlands-2021-2022.pdf',
                //   ),
                // ),
                buildAccountOptionRow(
                    context,
                    DemoLocalizations.of(context)!.trans('social'),
                    FontAwesomeIcons.hashtag,
                    SocialPage()),
                buildNotificationOptionRow(
                    "Auto load video's",
                    FontAwesomeIcons.wifi,
                    Platform.isIOS
                        ? CupertinoSwitch(
                            activeColor: Palette.accentColor,
                            value: isSwitchedFT,
                            onChanged: (bool value) {
                              setState(() {
                                isSwitchedFT = value;
                                saveSwitchState(value);
                                print('Saved state is $isSwitchedFT');
                              });
                              print(isSwitchedFT);
                            },
                          )
                        : Switch(
                            activeColor: Palette.accentColor,
                            value: isSwitchedFT,
                            onChanged: (bool value) {
                              setState(() {
                                isSwitchedFT = value;
                                saveSwitchState(value);
                                print('Saved state is $isSwitchedFT');
                              });
                              print(isSwitchedFT);
                            },
                          )),

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
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Development',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: kSecondaryBgColor,
                borderRadius: BorderRadius.circular(kBorderRadius),
                boxShadow: [kBoxShadow]),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  child: FaIcon(
                    FontAwesomeIcons.code,
                    color: Palette.indigo,
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Contributors',
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
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14),
                        children: [
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString(
                              'https://www.rotary.nl/yep/yep-app/privacy-policy.html',
                            );
                          },
                      ),
                    ])),
                RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14),
                        children: [
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString(
                              'https://www.rotary.nl/yep/yep-app/terms-and-conditions.html',
                            );
                          },
                      ),
                    ])),
              ],
            ),
          ),
          Center(
            child: Text(
              'App version: ${_packageInfo.version} (${_packageInfo.buildNumber})',
              style: TextStyle(color: Color(0xFF777777)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Container buildNotificationOptionRow(
    String title,
    IconData icon,
    Widget aSwitch,
  ) {
    return Container(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            child: FaIcon(
              icon,
              color: Palette.indigo,
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
      // color: Palette.themeCardShadeColor,
      child: ListTile(
        leading: FaIcon(
          icon,
          color: Palette.indigo,
        ),
        title: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
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
              Transform.translate(
                offset: Offset(0, 15),
                child: Divider(
                  thickness: 0.1,
                  height: 0.1,
                ),
              ),
            ],
          ),
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
