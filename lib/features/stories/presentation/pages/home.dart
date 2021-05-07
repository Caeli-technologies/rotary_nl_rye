// @dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/languages.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/question.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/settings.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/stories.dart';

import 'package:rotary_nl_rye/features/stories/presentation/pages/aboutpage.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/presentation/widgets/home_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Device.width = MediaQuery.of(context).size.width;
    Device.height = MediaQuery.of(context).size.height;
    Device.isDark =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Palette.instance;

    return DefaultTabController(
        length: 5,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: Palette.themeShadeColor,
            child: TabBar(
                tabs: [
                  Container(
                      height: 90,
                      child: Tab(icon: FaIcon(Icons.home, size: 35))),
                  Container(
                      height: 90,
                      child: Tab(
                          icon: Icon(FontAwesomeIcons.newspaper, size: 35))),
                  Container(
                      height: 90,
                      child: Tab(
                          icon: FaIcon(FontAwesomeIcons.question, size: 35))),
                  Container(
                      height: 90,
                      child: Tab(
                          icon:
                              FaIcon(FontAwesomeIcons.addressCard, size: 35))),
                  Container(
                      height: 90,
                      child: Tab(icon: FaIcon(FontAwesomeIcons.cog, size: 35))),
                ],
                unselectedLabelColor: Palette.lightIndigo,
                labelColor: Palette.indigo,
                indicatorColor: Colors.transparent),
          ),
          body: TabBarView(
            children: [
              //home
              HomeScreen(),
              /*      
              ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 60, right: 20),
                    child: Text(
                      DemoLocalizations.of(context).trans('homeTitle'),
                      textScaleFactor: 2.4,
                      style: TextStyle(
                          color: Palette.indigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: HomeScreen(),
                  ),
                ],
              ),
            */
              //stories
              ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 60, right: 20),
                    child: Text(
                      DemoLocalizations.of(context).trans('storiesHomeHeader'),
                      textScaleFactor: 2.4,
                      style: TextStyle(
                          color: Palette.indigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: InnerTab(),
                  ),
                ],
              ),
              //FAQ
              QuestionPage(),
              //about us
              AboutPage(),
              //settings
              SettingsPage(),
            ],
          ),
        ));
  }
}
