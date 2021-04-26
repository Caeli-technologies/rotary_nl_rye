// @dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/main.dart';

import 'package:rotary_nl_rye/views/question.dart';
import 'package:rotary_nl_rye/views/stories.dart';
import 'package:rotary_nl_rye/views/settings.dart';
import 'package:rotary_nl_rye/views/aboutpage.dart';
import 'package:rotary_nl_rye/views/prop.dart';

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
                      height: 90, child: Tab(icon: Icon(Icons.home, size: 35))),
                  Container(
                      height: 90,
                      child: Tab(
                          icon: FaIcon(FontAwesomeIcons.newspaper, size: 35))),
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
              ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 40, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Hai, Ulul!',
                          textScaleFactor: 1,
                          style: TextStyle(color: Palette.grey),
                        ),
                        CircleAvatar(
                          backgroundImage:
                              ExactAssetImage('assets/image/1.PNG'),
                          minRadius: 20,
                          maxRadius: 20,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Text(
                      'Mau \nLiburan \nKemana, bos?',
                      textScaleFactor: 2.4,
                      style: TextStyle(
                          color: Palette.indigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
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
