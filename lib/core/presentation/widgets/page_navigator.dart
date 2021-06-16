import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_nl_rye/core/firebase/check_update.dart';
import 'package:rotary_nl_rye/core/firebase/firebase_cloud_messaging.dart';
import 'package:rotary_nl_rye/core/firebase/firebase_dynamic_links.dart';

import '../../../features/about/presentation/pages/about_page.dart';
import '../../../features/contact/presentation/pages/contact_page.dart';
import '../../../features/faq/presentation/pages/question_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../prop.dart';
import 'bottom_navigation_bar.dart';

class PageNavigator extends StatefulWidget {
  @override
  _PageNavigatorState createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  String _appBadgeSupported = 'Unknown';

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
            SvgPicture.svgStringDecoder, 'assets/icons/flags/ca.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoder, 'assets/icons/flags/mx.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoder, 'assets/icons/flags/pe.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoder, 'assets/icons/flags/ec.svg'),
        null,
      ),
    ]);
    // end

// QuickActions start

    // final QuickActions quickActions = QuickActions();
    // quickActions.initialize((shortcutType) {
    //   if (shortcutType == 'action_main') {
    //     print('The user tapped on the "Main view" action.');
    //   }
    //   // More handling code...
    // });
    // quickActions.setShortcutItems(<ShortcutItem>[
    //   const ShortcutItem(
    //       type: 'action_main', localizedTitle: 'Main view', icon: 'icon_main'),
    //   const ShortcutItem(
    //       type: 'action_help', localizedTitle: 'Help', icon: 'icon_help')
    // ]);
// QuickActions end
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

    print("Badge supported: $_appBadgeSupported\n");
  }
// end

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
        bottomNavigationBar: BottomNavigatorBar(),
        body: TabBarView(
          children: [
            // home
            HomePage(),
            // About the organization page
            AboutPage(),
            // FAQ
            QuestionPage(),
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

void _addBadge() {
  FlutterAppBadger.updateBadgeCount(1);
}
