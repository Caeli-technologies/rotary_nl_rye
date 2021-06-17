// @dart=2.9

import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/custom_routes.dart';
import 'core/lang/languages.dart';
import 'core/presentation/widgets/page_navigator.dart';
import 'injection_container.dart' as di;

// void main() async {
//   runZonedGuarded<Future<void>>(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp();
//     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
//     await di.init();
//     SystemChrome.setPreferredOrientations(
//         [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

//     runApp(new MyApp());
//   }, FirebaseCrashlytics.instance.recordError);
// }

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) await Firebase.initializeApp();

  print('Got a message whilst in the BACKGROUND or TERMINATED!');

  if (message.notification != null) {
    print(
        'Message also contained a notification, with the following:\nTitle: ${message.notification?.title}\nBody: ${message.notification?.body}');
  }
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("Handling a background message ${message.data}");
// }

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
      // Platform.isIOS ? null :
      _firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await di.init();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    runApp(new MyApp());
  }, FirebaseCrashlytics.instance.recordError);
  // Pass all uncaught errors from the framework to Crashlytics.
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('en', 'GB'),
        const Locale('nl', ''),
        const Locale('de', ''),
        const Locale('pt', 'PT'),
        const Locale('pt', 'BR'),
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hans',
            countryCode: 'CN'), // 'zh_Hans_CN'
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant',
            countryCode: 'TW'), // 'zh_Hant_TW'
        const Locale('es', ''),
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData.light(),
      // Provide light theme.
      darkTheme: ThemeData.dark(),
      // Provide dark theme.
      themeMode: ThemeMode.system,
      title: 'Rotary youth Exchange',
      debugShowCheckedModeBanner: false,
      home: PageNavigator(),
      //routing in "lib/core/custom_routes.dart"
      routes: customRoutes,
    );
  }
}
