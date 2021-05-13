// @dart=2.9
import 'package:flutter/material.dart';

import '../../../../core/prop.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'contact_page.dart';
import 'home_page.dart';
import 'question_page.dart';
import 'settings_page.dart';
import 'stories_page.dart';

class PageNavigator extends StatefulWidget {
  @override
  _PageNavigatorState createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
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
            //TODO still need to add and move the StoriesPage() to the rebound button
            // About the organization page
            //AboutPage(),

            // stories
            StoriesPage(),
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
