import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/data/check_update.dart';
import 'package:rotary_nl_rye/features/calendar/presentation/pages/events_page.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/pages/inbound_page.dart';
import 'package:rotary_nl_rye/features/news/models/news.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/news_page.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/pages/outbound_page.dart';
import 'package:rotary_nl_rye/features/programs/presentation/pages/program_page.dart';
import 'package:rotary_nl_rye/features/stories/data/utils.dart';
import 'package:rotary_nl_rye/features/stories/models/exchange_student.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/countries_page.dart';

import '../../../home/presentation/widgets/home_card_item.dart';
import '../../../news/data/utils.dart' as data;
import '../widgets/carousel_display.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    FirebaseAuth.instance.signInAnonymously().then(
        (UserCredential userCredential) =>
            _currentSubscription = data.loadNews().listen(_updateNews));
  }

  String _appBadgeSupported = 'Unknown';
  late News _news;
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>
      _currentSubscription;
  bool _isLoading = true;
  List<ExchangeStudent> exchangeStudents = [];

  Future readJson(String url) async {
    // final String response =
    //     await rootBundle.loadString('assets/test/stories.json');
    final data = await getDataStudents(url);
    exchangeStudents = data;
    setState(() {
      _isLoading = false;
    });
  }

  _updateNews(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _isLoading = false;
    _news = data.getNewsFromQuery(snapshot);
    readJson(_news.students);
  }

  @override
  initState() {
    super.initState();
    initPlatformState();
    _removeBadge();
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }

    Future.wait([
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoder, 'assets/icons/flags/ca.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoder, 'assets/icons/flags/mx.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoder, 'assets/icons/flags/pe.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoder, 'assets/icons/flags/ec.svg'),
        null,
      ),
    ]);
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
  void dispose() {
    _currentSubscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            // Body
            body: Container(
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: 90,
                    margin: EdgeInsets.only(
                        left: 16, right: 16, bottom: 24, top: 10),
                    child: SvgPicture.asset(
                        'assets/image/rotary_rye_nl_logo_home.svg'),
                  ),

                  // Slider images
                  Carousel(),

                  // navigator buttons
                  Container(
                    margin: EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            HomeCardItem(
                                icon: FontAwesomeIcons.list,
                                title: 'Programs',
                                description:
                                    'information to apply and more things',
                                pushTo: ProgramPage()),
                            HomeCardItem(
                                icon: FontAwesomeIcons.newspaper,
                                title: 'News',
                                description: 'rebound page',
                                pushTo: NewsPage(
                                  news: _news,
                                )),
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
                                pushTo: CountriesPage(
                                  students: exchangeStudents,
                                )),
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
