// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/repository/news_repository_impl.dart';
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/non_pdf_news.dart';
import 'package:rotary_nl_rye/features/news/presentation/widgets/pdf_viewer.dart';
import 'package:rotary_nl_rye/main.dart';
import '../../injection_container.dart';

Future<void> getToken() async {
  FirebaseMessaging.instance.getToken().then((token) {
    print(token); // Print the Token in Console
  });
}

Future<void> getInitialMessages(BuildContext context) async {
  final _repo = NewsRepositoryImpl(sl());

  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) async {
    if (message?.data['navigation'] == '/news') {
      // test
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('newsBadge', 1);
      // end test
      _removeBadge();
      String id = message?.data['id'];
      print('news id $id');
      List<News>? _newsList = await _repo.news;
      if (_newsList != null) {
        print('news fetched ${_newsList[int.parse(id)].toString()}');
        _newsList[int.parse(id)].isPdf
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PDFPage(
                        pdfUrl: _newsList[int.parse(id)].pdf!,
                        data: _newsList[int.parse(id)])),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NonPDFPage(data: _newsList[int.parse(id)])));
      }
    }
  });
}

Future<void> onMessage(BuildContext context) async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    // test
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('newsBadge', 1);
// end test
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

              channelDescription: channel.description,

              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'ic_stat_rotary_logo_icon',
              color: Color(
                  0xFFf7a81b), // TODO still need to change to a better one
            ),
          ));
    }
  });
}

Future<void> onMessageOpenedApp(BuildContext context) async {
  final _repo = NewsRepositoryImpl(sl());

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print('A new onMessageOpenedApp event was published!');
    if (message.data['navigation'] == '/news') {
      // test
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('newsBadge', 1);
// end test
      String id = message.data['id'];
      print('news id $id');
      List<News>? _newsList = await _repo.news;
      if (_newsList != null) {
        print('news fetched ${_newsList[int.parse(id)].toString()}');
        _newsList[int.parse(id)].isPdf
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PDFPage(
                        pdfUrl: _newsList[int.parse(id)].pdf!,
                        data: _newsList[int.parse(id)])),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NonPDFPage(data: _newsList[int.parse(id)])));
      }
      print('onMessage: ${message.data}');
    }
  });
}

void _removeBadge() {
  FlutterAppBadger.removeBadge();
}
