// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/home_cards_item.dart';
import 'models/carousel_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body
      body: Container(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
                height: 90,
                margin:
                    EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 10),
                child: SvgPicture.asset(
                    'assets/image/rotary_rye_nl_logo_home.svg')),

            // idk if we need this but i will keep it for now
/*
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 24),
              child: Text(
                'Hi, NAME Some information for you!',
                style: TextStyle(fontSize: 16, color: Palette.lightIndigo),
              ),
            ),
*/

            // Slider images
            Carousel(),

/* 
            Padding(
              padding: EdgeInsets.only(left: 16, top: 24, bottom: 12),
              child: Text(
                'Let\'s Take a look (text still need to change!',
                style: TextStyle(fontSize: 12, color: Palette.lightIndigo),
              ),
            ),
*/
            SizedBox(
              height: 24,
            ),
            // navigator buttons
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      HomeCardsItem(
                          icon: FontAwesomeIcons.list,
                          title: 'Program',
                          description: 'information to apply and more things'),
                      HomeCardsItem(
                          icon: FontAwesomeIcons.reply,
                          title: 'Outbound',
                          description:
                              'students that are going to a diffrent country'),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      HomeCardsItem(
                          icon: FontAwesomeIcons.share,
                          title: 'Inbound',
                          description:
                              'people that are going to the netherlands'),
                      HomeCardsItem(
                          icon: FontAwesomeIcons.redoAlt,
                          title: 'Rebound',
                          description: 'rebound page'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}