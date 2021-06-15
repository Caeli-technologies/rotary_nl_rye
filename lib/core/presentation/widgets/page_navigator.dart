import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rotary_nl_rye/core/bloc/repository.dart';
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
  Repository _repo = Repository();

  @override
  initState() {
    this._initDynamicLinks();
    super.initState();

    FirebaseMessaging.instance.getToken().then((token) {
      print(token); // Print the Token in Console
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message?.data["navigation"] == "/news") {
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
      // print('A new onMessage event was published!');
      // if (message.data["navigation"] == "/news") {
      //   String id = message.data["id"];
      //   print('news id $id');
      //   List<News> _newsList = await _repo.fetchNews();
      //   print('news fetched ${_newsList[int.parse(id)].toString()}');
      //   _newsList[int.parse(id)].isPdf
      //       ? Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => PDFPage(
      //                   pdfId: _newsList[int.parse(id)],
      //                   pdfUrl: _newsList[int.parse(id)].pdf!)),
      //         )
      //       : Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) =>
      //                   NonPDFPage(data: _newsList[int.parse(id)])));
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      if (message.data["navigation"] == "/news") {
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
  }

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
}
