// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/calendar/presentation/pages/events_page.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/news_page.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/countries_page.dart';

import '../../../home/presentation/widgets/home_card_item.dart';
import '../widgets/carousel_display.dart';

import 'package:flutter_app_badger/flutter_app_badger.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _appBadgeSupported = 'Unknown';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
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
    print("Badge supported: $_appBadgeSupported\n");

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });
  }

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
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 10),
              child:
                  SvgPicture.asset('assets/image/rotary_rye_nl_logo_home.svg'),
            ),

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
            // navigator buttons
            Container(
              margin: EdgeInsets.only(top: 24, left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      HomeCardItem(
                          icon: FontAwesomeIcons.list,
                          title: 'Program',
                          description: 'information to apply and more things',
                          pushTo: null),
                      HomeCardItem(
                          icon: FontAwesomeIcons.newspaper,
                          title: 'News',
                          description: 'rebound page',
                          pushTo: NewsPage()),
                      HomeCardItem(
                          icon: FontAwesomeIcons.calendarAlt,
                          title: 'Calendar',
                          description:
                              'people that are going to the netherlands',
                          pushTo: TableEvents()),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      HomeCardItem(
                          icon: FontAwesomeIcons.reply,
                          title: 'Outbound',
                          description:
                              'students that are going to a diffrent country',
                          pushTo: null),
                      HomeCardItem(
                          icon: FontAwesomeIcons.share,
                          title: 'Inbound',
                          description:
                              'people that are going to the netherlands',
                          pushTo: null),
                      HomeCardItem(
                          icon: FontAwesomeIcons.redoAlt,
                          title: 'Rebound',
                          description: 'rebound page',
                          pushTo: CountriesPage()),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
/*
                  ElevatedButton(
                    child: new Text('Add badge'),
                    onPressed: () {
                      _addBadge();
                    },
                  ),
                  ElevatedButton(
                      child: new Text('Remove badge'),
                      onPressed: () {
                        _removeBadge();
                      }),
*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addBadge() {
    FlutterAppBadger.updateBadgeCount(1);
  }

  void _removeBadge() {
    FlutterAppBadger.removeBadge();
  }
}
