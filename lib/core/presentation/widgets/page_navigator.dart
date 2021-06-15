import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:quick_actions/quick_actions.dart';
import 'package:rotary_nl_rye/core/bloc/repository.dart';
import 'package:rotary_nl_rye/core/data/check_update.dart';
import 'package:rotary_nl_rye/features/news/models/firestore_url.dart';
import 'package:rotary_nl_rye/features/news/models/news.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/non_pdf_news.dart';
import 'package:rotary_nl_rye/features/news/presentation/widgets/pdf_viewer.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/social.dart';
import 'package:rotary_nl_rye/main.dart';

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
  late FireStoreUrl _news;
  String _appBadgeSupported = 'Unknown';
  Repository _repo = Repository();

  @override
  initState() {
    this._initDynamicLinks();
    appBadgeSupportedState();
    _removeBadge();
    super.initState();

    FirebaseMessaging.instance.getToken().then((token) {
      print(token); // Print the Token in Console
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message?.data["navigation"] == "/news") {
        _removeBadge();
        String id = message?.data["id"];
        print('news id $id');
        List<News> _newsList = await _repo.fetchNews();
        print('news fetched ${_newsList[int.parse(id)].toString()}');
        _newsList[int.parse(id)].isPdf
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PDFPage(
                        pdfId: _newsList[int.parse(id)],
                        pdfUrl: _newsList[int.parse(id)].pdf!)),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NonPDFPage(data: _newsList[int.parse(id)])));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'ic_stat_rotary_logo_icon',
                color: Color(
                    0xFFf7a81b), // TODO still need to change to a better one
              ),
            ));
      }
      print('onMessage: ${message.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");

      // if (message.data["navigation"] == "/news") {
      //   int _yourId = int.tryParse(message.data["id"]) ?? 0;
      //   Navigator.push(
      //       navigatorKey.currentState!.context,
      //       MaterialPageRoute(
      //           builder: (context) => SocialPage(
      //                 id: _yourId,
      //               )));
      // }

      if (message.data["navigation"] == "/news") {
        _removeBadge();
        String id = message.data["id"];
        print('news id $id');
        List<News> _newsList = await _repo.fetchNews();
        print('news fetched ${_newsList[int.parse(id)].toString()}');
        _newsList[int.parse(id)].isPdf
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PDFPage(
                        pdfId: _newsList[int.parse(id)],
                        pdfUrl: _newsList[int.parse(id)].pdf!)),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NonPDFPage(data: _newsList[int.parse(id)])));
      }
    });
// versionCheck firebase remote config
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }
// end

// render complex SVG
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
    // end

// QuickActions start

    // final QuickActions quickActions = QuickActions();
    // quickActions.initialize((shortcutType) {
    //   if (shortcutType == 'action_main') {
    //     print('The user tapped on the "Main view" action.');
    //   }
    //   // More handling code...
    // });
    // quickActions.setShortcutItems(<ShortcutItem>[
    //   const ShortcutItem(
    //       type: 'action_main', localizedTitle: 'Main view', icon: 'icon_main'),
    //   const ShortcutItem(
    //       type: 'action_help', localizedTitle: 'Help', icon: 'icon_help')
    // ]);
// QuickActions end
  }

// app Badge Supported
  appBadgeSupportedState() async {
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
// end

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

// Dynamic links start

  Future<void> _initDynamicLinks() async {
    // TODO "onLink" is when the app is open and on the homescreen.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        final uri = deepLink.path;
        print("deepLink.path: $uri ");
        if (deepLink.path == "/helloworld") {
          // final id = deepLink.queryParameters["id"];
          // final name = deepLink.queryParameters["name"];
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SocialPage()));
        }
        if (deepLink.path == "/stories") {
          // final id = deepLink.queryParameters["id"];
          // final name = deepLink.queryParameters["name"];
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SocialPage()));
        }
        if (deepLink.path == "/news") {
          String? id = deepLink.queryParameters["id"];
          print('news id $id');
          List<News> _newsList = await _repo.fetchNews();
          print('news fetched ${_newsList[int.parse(id!)].toString()}');
          _newsList[int.parse(id)].isPdf
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PDFPage(
                          pdfId: _newsList[int.parse(id)],
                          pdfUrl: _newsList[int.parse(id)].pdf!)),
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NonPDFPage(data: _newsList[int.parse(id)])));
        }
        // still need some work
        Navigator.pushNamed(context, '${deepLink.path}');
      }
    }, onError: (OnLinkErrorException e) async {
      Navigator.pushNamed(context, '/error');
    });

// TODO "getInitialLink" is when the app is closed.
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    final uri = deepLink?.path;

    print("deepLink.path: $uri ");
    if (deepLink?.path == "/helloworld") {
      // final id = deepLink?.queryParameters["id"];
      // final name = deepLink?.queryParameters["name"];
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SocialPage()));
    }
    if (deepLink?.path == "/stories") {
      // final id = deepLink?.queryParameters["id"];
      // final name = deepLink?.queryParameters["name"];
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SocialPage()));
    }
    if (deepLink?.path == "/news") {
      String? id = deepLink?.queryParameters["id"];
      List<News> _newsList = await _repo.fetchNews();

      _newsList[int.parse(id!)].isPdf
          ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PDFPage(
                      pdfId: _newsList[int.parse(id)],
                      pdfUrl: _newsList[int.parse(id)].pdf!)),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NonPDFPage(data: _newsList[int.parse(id)])));
    }
    // still need some work
    // Navigator.pushNamed(context, '${deepLink?.path}');
  }

// Dynamic links end

}

void _removeBadge() {
  FlutterAppBadger.removeBadge();
}

void _addBadge() {
  FlutterAppBadger.updateBadgeCount(1);
}
