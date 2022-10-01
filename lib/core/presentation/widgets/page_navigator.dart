// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/firebase/check_update.dart';
import 'package:rotary_nl_rye/core/firebase/firebase_cloud_messaging.dart';
import 'package:rotary_nl_rye/core/firebase/firebase_dynamic_links.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/about/presentation/pages/about_page.dart';
import 'package:rotary_nl_rye/features/contact/presentation/pages/contact_page.dart';
import 'package:rotary_nl_rye/features/emergency/presentation/pages/emergency_page.dart';
import 'package:rotary_nl_rye/features/home/presentation/pages/home_page.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/settings_page.dart';

class PageNavigator extends StatefulWidget {
  @override
  _PageNavigatorState createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  String _appBadgeSupported = 'Unknown';
  int _selectedindex = 0;

  @override
  initState() {
    initDynamicLinks(context);
    appBadgeSupportedState();
    //FCM start
    getToken();
    getInitialMessages(context);
    onMessage(context);
    onMessageOpenedApp(context);
    //FCm end
    _removeBadge();
    super.initState();
    // versionCheck firebase remote config
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }

// render complex SVG
    Future.wait([
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder, 'assets/icons/flags/ca.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder, 'assets/icons/flags/mx.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder, 'assets/icons/flags/pe.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder, 'assets/icons/flags/ec.svg'),
        null,
      ),
    ]);
    // end
  }

// app Badge Supported
  appBadgeSupportedState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });

    print('Badge supported: $_appBadgeSupported\n');
  }
// end

  void _onItemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });

    // print(_selectedindex);
  }

  @override
  Widget build(BuildContext context) {
    // TODO add it to theme data
    Device.width = MediaQuery.of(context).size.width;
    Device.height = MediaQuery.of(context).size.height;
    Device.isDark =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Palette.instance;

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 20.0),
          color: Palette.themeShadeColor,
          child: TabBar(
            tabs: [
              Tab(
                  icon: Icon(
                FontAwesomeIcons.house,
                size: 30,
                color: (_selectedindex == 0)
                    ? Palette.indigo
                    : Palette.lightIndigo,
              )),
              Tab(
                  icon: Icon(
                FontAwesomeIcons.userGroup,
                size: 30,
                color: (_selectedindex == 1)
                    ? Palette.indigo
                    : Palette.lightIndigo,
              )),
              Tab(
                  icon: Icon(
                FontAwesomeIcons.triangleExclamation,
                size: 30,
                color: (_selectedindex == 2) ? Colors.red : Colors.red[200],
              )),
              Tab(
                  icon: Icon(
                FontAwesomeIcons.addressBook,
                size: 30,
                color: (_selectedindex == 3)
                    ? Palette.indigo
                    : Palette.lightIndigo,
              )),
              Tab(
                  icon: Icon(
                FontAwesomeIcons.gear,
                size: 30,
                color: (_selectedindex == 4)
                    ? Palette.indigo
                    : Palette.lightIndigo,
              )),
            ],
            // unselectedLabelColor:
            //     (_selectedindex == 2) ? Palette.lightIndigo : Colors.red,
            // labelColor: Palette.indigo,
            indicatorColor: Colors.transparent,
            onTap: _onItemTapped,
          ),
        ),
        body: TabBarView(
          children: [
            // home
            HomePage(),
            // About the organization page
            AboutPage(),
            // Emergency
            EmergencyPage(),
            // about us
            ContactPage(),
            // settings
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}

void _removeBadge() {
  FlutterAppBadger.removeBadge();
}

// void _addBadge() {
//   FlutterAppBadger.updateBadgeCount(1);
// }
