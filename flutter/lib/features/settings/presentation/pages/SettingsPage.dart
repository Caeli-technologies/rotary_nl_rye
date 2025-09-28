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
import 'package:rotary_nl_rye/features/settings/presentation/pages/SocialPage.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/contributors_page.dart';

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
  void initState() {
    super.initState();
    _initPackageInfo();
    _loadSwitchValue();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> _loadSwitchValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitchedFT = prefs.getBool('autoInitializeState') ?? false;
    });
  }

  Future<void> _saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoInitializeState', value);
    setState(() {
      isSwitchedFT = value;
    });
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
        title: Text(
          DemoLocalizations.of(context)!.trans('settingsTitle'),
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
                subject: 'Look at this nice app :)',
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: [
          _buildSectionTitle(context, 'account'),
          SizedBox(height: 10),
          _buildSettingsContainer([
            _buildAccountOptionRow(context, 'Pictures', FontAwesomeIcons.images,
                GalleryViewPage()),
            _buildAccountOptionRow(
                context,
                DemoLocalizations.of(context)!.trans('social'),
                FontAwesomeIcons.hashtag,
                SocialPage()),
            _buildSwitchOptionRow(
                context,
                'Auto load videos',
                FontAwesomeIcons.wifi,
                Platform.isIOS
                    ? CupertinoSwitch(
                        activeTrackColor: Palette.accentColor,
                        value: isSwitchedFT,
                        onChanged: _saveSwitchState,
                      )
                    : Switch(
                        activeColor: Palette.accentColor,
                        value: isSwitchedFT,
                        onChanged: _saveSwitchState,
                      )),
          ]),
          SizedBox(height: 30),
          _buildSectionTitle(context, 'Development'),
          SizedBox(height: 10),
          _buildSettingsContainer([
            ListTile(
              leading: FaIcon(FontAwesomeIcons.code, color: Palette.indigo),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Contributors',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Palette.grey),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Palette.grey),
                ],
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContributorsPage())),
            ),
          ]),
          SizedBox(height: 20),
          _buildFooter(context),
          Center(
            child: Text(
              'App version: ${_packageInfo.version} (${_packageInfo.buildNumber})',
              style: TextStyle(color: Color(0xFF777777)),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Padding _buildSectionTitle(BuildContext context, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        DemoLocalizations.of(context)!.trans(key),
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container _buildSettingsContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: kSecondaryBgColor,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: [kBoxShadow],
      ),
      child: Column(children: children),
    );
  }

  Container _buildSwitchOptionRow(
      BuildContext context, String title, IconData icon, Widget switchWidget) {
    return Container(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: FaIcon(icon, color: Palette.indigo),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Palette.grey),
            ),
            switchWidget,
          ],
        ),
      ),
    );
  }

  GestureDetector _buildAccountOptionRow(
      BuildContext context, String title, IconData icon, Widget pushTo) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.zero,
        child: ListTile(
          leading: FaIcon(icon, color: Palette.indigo),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Palette.grey),
              ),
              Icon(Icons.arrow_forward_ios, color: Palette.grey),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pushTo),
            );
          },
        ),
      ),
    );
  }

  Padding _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildFooterLink(context, 'Privacy Policy',
              'https://www.rotary.nl/yep/yep-app/privacy-policy.html'),
          _buildFooterLink(context, 'Terms & Conditions',
              'https://www.rotary.nl/yep/yep-app/terms-and-conditions.html'),
        ],
      ),
    );
  }

  RichText _buildFooterLink(BuildContext context, String text, String url) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
        children: [
          TextSpan(
            text: text,
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrlString(url),
          ),
        ],
      ),
    );
  }
}
