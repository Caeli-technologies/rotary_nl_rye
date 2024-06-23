// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_app_badger/flutter_app_badger.dart';
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
import 'package:rotary_nl_rye/features/settings/presentation/pages/SettingsPage.dart';

class PageNavigator extends StatefulWidget {
  @override
  _PageNavigatorState createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  String _appBadgeSupported = 'Unknown';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await initDynamicLinks(context);
    await _checkAppBadgeSupport();
    await _initializeFCM();
    _removeBadge();
    _checkVersion();
  }

  Future<void> _initializeFCM() async {
    await getToken();
    await getInitialMessages(context);
    onMessage(context);
    onMessageOpenedApp(context);
  }

  Future<void> _checkVersion() async {
    try {
      await versionCheck(context);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _checkAppBadgeSupport() async {
    try {
      bool isSupported = await FlutterAppBadger.isAppBadgeSupported();
      setState(() {
        _appBadgeSupported = isSupported ? 'Supported' : 'Not supported';
      });
      print('Badge supported: $_appBadgeSupported\n');
    } on PlatformException {
      setState(() {
        _appBadgeSupported = 'Failed to get badge support.';
      });
    }
  }

  void _removeBadge() {
    FlutterAppBadger.removeBadge();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Device.width = MediaQuery.of(context).size.width;
    Device.height = MediaQuery.of(context).size.height;
    Palette.initialize(
        MediaQuery.of(context).platformBrightness == Brightness.dark);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: TabBarView(
          children: [
            HomePage(),
            AboutPage(),
            EmergencyPage(),
            ContactPage(),
            SettingsPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      color: Palette.themeShadeColor,
      child: TabBar(
        tabs: [
          _buildTabIcon(FontAwesomeIcons.house, 0),
          _buildTabIcon(FontAwesomeIcons.userGroup, 1),
          _buildTabIcon(FontAwesomeIcons.triangleExclamation, 2,
              activeColor: Colors.red, inactiveColor: Colors.red[200]),
          _buildTabIcon(FontAwesomeIcons.addressBook, 3),
          _buildTabIcon(FontAwesomeIcons.gear, 4),
        ],
        indicatorColor: Colors.transparent,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildTabIcon(IconData icon, int index,
      {Color? activeColor, Color? inactiveColor}) {
    final Color color = _selectedIndex == index
        ? (activeColor ?? Palette.indigo)
        : (inactiveColor ?? Palette.lightIndigo);
    return Tab(icon: Icon(icon, size: 30, color: color));
  }
}
