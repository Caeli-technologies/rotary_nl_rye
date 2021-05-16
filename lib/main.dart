// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rotary_nl_rye/core/data/datasource/firestore.dart';

import 'core/lang/languages.dart';
import 'core/presentation/widgets/page_navigator.dart';
import 'injection_container.dart' as di;

void main() async {
  runApp(new MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetData(collection: "/countries/MswAY4E5FR3r4LBNSdrB/exchangeStudents")
      .call();
  await di.init();
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
        const Locale('fr', 'FR'),
        const Locale('de', 'DE'),
        const Locale('dk', 'DK'),
        const Locale('no', 'NO'),
        const Locale('nl', 'NL'),
        const Locale('sv', 'SE'),
        const Locale('it', 'IT'),
        const Locale('pl', 'PL'),
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hans',
            countryCode: 'CN'), // 'zh_Hans_CN'
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant',
            countryCode: 'TW'), // 'zh_Hant_TW'
        const Locale('si', 'SI'),
        const Locale('es', 'ES'),
        const Locale('id', 'ID'),
        const Locale('he', 'IL'),
        const Locale('ar', 'AE'),
        const Locale('he', 'IL'),
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData.light(), // Provide light theme.
      darkTheme: ThemeData.dark(), // Provide dark theme.
      themeMode: ThemeMode.system,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: PageNavigator(),
    );
  }
}
