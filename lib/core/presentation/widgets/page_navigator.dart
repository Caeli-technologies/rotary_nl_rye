// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/about/presentation/pages/about_page.dart';
import 'package:rotary_nl_rye/features/contact/presentation/pages/contact_page.dart';
import 'package:rotary_nl_rye/features/emergency/presentation/pages/emergency_page.dart';
import 'package:rotary_nl_rye/features/home/presentation/pages/home_page.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/SettingsPage.dart';

import 'dart:io' show Platform; // For platform detection

import 'package:flutter/cupertino.dart'; // For iOS Cupertino components


class PageNavigator extends StatefulWidget {
  @override
  _PageNavigatorState createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    AboutPage(),
    EmergencyPage(),
    ContactPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Device.width = MediaQuery.of(context).size.width;
    Device.height = MediaQuery.of(context).size.height;
    Palette.initialize(
        MediaQuery.of(context).platformBrightness == Brightness.dark);

    // Platform-specific design
    if (Platform.isIOS) {
      return _buildIOSNavigator(); // Use only CupertinoTabBar for iOS
    } else {
      return _buildAndroidNavigator(); // Standard BottomNavigationBar for Android
    }
  }

  // iOS-specific navigation using CupertinoTabScaffold (no AppBar)
  Widget _buildIOSNavigator() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        activeColor: Palette.indigo,
        inactiveColor: Palette.lightIndigo,
        items: [
          _buildCupertinoTabItem(FontAwesomeIcons.house, 'Home'),
          _buildCupertinoTabItem(FontAwesomeIcons.userGroup, 'About'),
          _buildCupertinoTabItem(
              FontAwesomeIcons.triangleExclamation, 'Emergency',
              activeColor: Colors.red, inactiveColor: Colors.red[200]),
          _buildCupertinoTabItem(FontAwesomeIcons.addressBook, 'Contact'),
          _buildCupertinoTabItem(FontAwesomeIcons.gear, 'Settings'),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return _pages[index]; // Just display the page, no AppBar
      },
    );
  }

  // Android-specific navigation using BottomNavigationBar
  Widget _buildAndroidNavigator() {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: _buildAndroidBottomNavigationBar(),
    );
  }

  // Android-specific bottom navigation bar (fancy floating design)
  Widget _buildAndroidBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Palette.themeShadeColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Palette.themeShadeColor,
          selectedItemColor: Palette.indigo,
          unselectedItemColor: Palette.lightIndigo,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          items: [
            _buildBottomNavigationBarItem(FontAwesomeIcons.house, 'Home'),
            _buildBottomNavigationBarItem(FontAwesomeIcons.userGroup, 'About'),
            _buildBottomNavigationBarItem(
                FontAwesomeIcons.triangleExclamation, 'Emergency',
                activeColor: Colors.red, inactiveColor: Colors.red[200]),
            _buildBottomNavigationBarItem(
                FontAwesomeIcons.addressBook, 'Contact'),
            _buildBottomNavigationBarItem(FontAwesomeIcons.gear, 'Settings'),
          ],
        ),
      ),
    );
  }

  // Cupertino-style tab item builder
  BottomNavigationBarItem _buildCupertinoTabItem(IconData icon, String label,
      {Color? activeColor, Color? inactiveColor}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  // Android-specific bottom navigation bar item builder
  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String label,
      {Color? activeColor, Color? inactiveColor}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
