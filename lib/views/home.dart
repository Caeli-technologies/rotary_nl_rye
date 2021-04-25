// @dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:rotary_nl_rye/views/question.dart';
import 'package:rotary_nl_rye/views/stories.dart';
import 'package:rotary_nl_rye/views/settings.dart';
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

    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            color: Colors.grey[100],
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
                unselectedLabelColor: Colors.indigo[100],
                labelColor: Colors.indigo[800],
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
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        CircleAvatar(
                          backgroundImage: ExactAssetImage('assets/1.PNG'),
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
                          color: Color.fromRGBO(19, 33, 70, 1),
                          fontWeight: FontWeight.bold),
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
                      'Verhalen van Exchange studenten',
                      textScaleFactor: 2.4,
                      style: TextStyle(
                          color: Color.fromRGBO(19, 33, 70, 1),
                          fontWeight: FontWeight.bold),
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
              Center(
                child: Text("4"),
              ),
              //settings
              SettingsPage(),
            ],
          ),
        ));
  }
}
