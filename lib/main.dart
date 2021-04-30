// @dart=2.9
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'features/stories/data/datasources/languages.dart';
import 'features/stories/presentation/pages/home.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (!Platform.isIOS) {
            if (supportedLocale.languageCode == locale.languageCode ||
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
        }

        return supportedLocales.first;
      },
      theme: ThemeData.light(), // Provide light theme.
      darkTheme: ThemeData.dark(), // Provide dark theme.
      themeMode: ThemeMode.system,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

void main() async {
  runApp(new MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
