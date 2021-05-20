// @dart=2.9
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/calendar/presentation/pages/events_page.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/pages/inbound_page.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/news_page.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/pages/outbound_page.dart';
import 'package:rotary_nl_rye/features/program/presentation/pages/program_page.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/countries_page.dart';

import '../../../home/presentation/widgets/home_card_item.dart';
import '../widgets/carousel_display.dart';

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
    _removeBadge();
    var jsonSource = """
  {
   "items": [
{
   "kind": "calendar#event",
   "id": "1je584h0gd75qdp89n8ulej3tf",
   "status": "confirmed",
   "htmlLink": "https://www.google.com/calendar/event?eid=MWplNTg0aDBnZDc1cWRwODluOHVsZWozdGYgcnllLm5ldGhlcmxhbmRzQG0",
   "created": "2020-02-25T19:58:44.000Z",
   "updated": "2020-02-25T19:58:44.968Z",
   "summary": "Long Term Exchange Studenten",
   "description": "aankomst 7 nieuwe exchange (inbound) studenten in Nederland",
   "creator": {
    "email": "hpl.vanmontfort@gmail.com"
   },
   "organizer": {
    "email": "rye.netherlands@gmail.com",
    "self": true
   },
   "start": {
    "date": "2020-06-16"
   },
   "end": {
    "date": "2020-06-20"
   },
   "transparency": "transparent",
   "iCalUID": "1je584h0gd75qdp89n8ulej3tf@google.com",
   "sequence": 0,
   "eventType": "default"
  }
    ]
    }
  """;
    print(convertJsonToDateMap(jsonSource));
  }

  /// just a test but it works :)

  Map<DateTime, List> convertJsonToDateMap(String jsonSource) {
    var json = jsonDecode(jsonSource);
    var jsonEvents = json['items'];
    Map<DateTime, List<String>> events = {};
    for (var event in jsonEvents) {
      var date = parseDate(event['start']['date']);
      events.putIfAbsent(date, () => <String>[]);
      events[date].add(event['summary']);
      events[date].add(event['description']);
      events[date].add(event['start']['date']);
    }
    return events;
  }

  DateTime parseDate(String date) {
    var parts = date.split('-').map(int.tryParse).toList();
    return DateTime(parts[0], parts[1], parts[2]);
  }

  /// just a test

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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });

    print("Badge supported: $_appBadgeSupported\n");
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
                          pushTo: ProgramPage()),
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
                          pushTo: CalendarPage()),
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
                          pushTo: OutboundPage()),
                      HomeCardItem(
                          icon: FontAwesomeIcons.share,
                          title: 'Inbound',
                          description:
                              'people that are going to the netherlands',
                          pushTo: InboundPage()),
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
