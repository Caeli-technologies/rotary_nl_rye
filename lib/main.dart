// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

import 'core/lang/languages.dart';
import 'core/presentation/widgets/page_navigator.dart';
import 'features/stories/presentation/bloc/countries_bloc.dart';
import 'features/stories/presentation/bloc/stories_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(MultiBlocProvider(providers: [
    BlocProvider<CountriesBloc>(
      create: (_) => sl<CountriesBloc>(),
    ),
    BlocProvider<StoriesBloc>(
      create: (_) => sl<StoriesBloc>(),
    ),
  ], child: new MyApp()));
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
        const Locale('en', ''),
        const Locale('nl', ''),
        const Locale('de', ''),
        const Locale('pt', ''),
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
      theme: ThemeData.light(), // Provide light theme.
      darkTheme: ThemeData.dark(), // Provide dark theme.
      themeMode: ThemeMode.system,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: PageNavigator(),
    );
  }
}
