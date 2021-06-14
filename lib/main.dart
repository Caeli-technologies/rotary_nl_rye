// @dart=2.9

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
