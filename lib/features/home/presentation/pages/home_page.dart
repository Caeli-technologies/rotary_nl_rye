import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/data/check_update.dart';
import 'package:rotary_nl_rye/core/path/firebase_dynamic_links.dart';
import 'package:rotary_nl_rye/features/calendar/presentation/pages/events_page.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/pages/inbound_page.dart';
import 'package:rotary_nl_rye/features/news/models/firestore_url.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/news_page.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/pages/outbound_page.dart';
import 'package:rotary_nl_rye/features/programs/presentation/pages/program_page.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/social.dart';
import 'package:rotary_nl_rye/features/stories/models/exchange_student.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/countries_page.dart';

import '../../../home/presentation/widgets/home_card_item.dart';
import '../widgets/carousel_display.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  _HomePageState() {
    // FirebaseAuth.instance.signInAnonymously().then(
    //     (UserCredential userCredential) =>
    //         _currentSubscription = data.loadNews().listen(_updateNews));
  }

  String _appBadgeSupported = 'Unknown';
  late FireStoreUrl _news;
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>
      _currentSubscription;
  bool _isLoading = true;
  List<ExchangeStudent> exchangeStudents = [];

  // Future readJson(String url) async {
  //   // final String response =
  //   //     await rootBundle.loadString('assets/test/stories.json');
  //   final data = await api.getDataStudentList(url);
  //   exchangeStudents = data;
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // _updateNews(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //   _isLoading = false;
  //   _news = data.getNewsFromQuery(snapshot);
  //   readJson(_news.students);
  // }

  @override
  initState() {
    super.initState();
    this._initDynamicLinks();

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

  Future<void> _initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        // Navigator.pushNamed(context, deepLink.path);
// ignore: unnecessary_statements

        // if (deepLink.queryParameters.containsKey('id')) {
        //   String? id = deepLink.queryParameters['id'];
        //   String? name = deepLink.queryParameters['name'];
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => SocialPage(id: id, name: name)));

        //   // Navigator.pushNamed(BuildContext context) => SocialPage(id: id, name: name);
        // }
        // print(deepLink.queryParameters['name']);
        // Navigator.pushNamed(context, deepLink.path);

        // if (deepLink.queryParameters.containsKey('id')) {
        //   // String _path = deepLink.path;
        //   String? id = deepLink.queryParameters['id'];
        //   String? name = deepLink.queryParameters['name'];
        //   // verify the username is parsed correctly
        //   print("My users username is: $name and $id");
        //   // Navigator.of(context).push(MaterialPageRoute(
        //   //     builder: (context) => SocialPage(id: id, name: name)));

        //   Navigator.pushNamed(
        //     context,
        //     '/helloworld',
        //     arguments: <String?, String?>{id: "id", name: "id"},
        //   );
        // }

        if (deepLink.path == "/helloworld") {
          final String? id = deepLink.queryParameters["id"];
          final String? name = deepLink.queryParameters["name"];
          // Make sure the ID is in place to be more robust against invalid deep links.

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SocialPage(id: id, name: name)));
        }
        if (deepLink.path == "/tutorials") {
          final id = deepLink.queryParameters["id"];
          final name = deepLink.queryParameters["name"];
          // Make sure the ID is in place to be more robust against invalid deep links.
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SocialPage(id: id, name: name)));
        }
      }
    }, onError: (OnLinkErrorException e) async {
      Navigator.pushNamed(context, '/error');
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      if (deepLink.queryParameters.containsKey('id')) {
        String? id = deepLink.queryParameters['id'];
        String? name = deepLink.queryParameters['name'];
        // verify the username is parsed correctly
        print("My users username is: $name and $id");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SocialPage(id: id, name: name)));

        // Navigator.pushNamed(BuildContext context) => SocialPage(id: id, name: name);
      }
    }
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
    //  _currentSubscription.cancel();
    // TODO: implement dispose
    super.dispose();
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

                  // going to the test page of Dynamic links
                  Row(
                    children: <Widget>[
                      HomeCardItem(
                          icon: FontAwesomeIcons.redoAlt,
                          title: 'test',
                          description: 'rebound page',
                          pushTo: DynamicLinks()),
                    ],
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
