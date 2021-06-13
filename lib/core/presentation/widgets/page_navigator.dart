import 'package:flutter/material.dart';

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
