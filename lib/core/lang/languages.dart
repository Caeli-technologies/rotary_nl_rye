// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  Map<String, String> _sentences;

  Future<bool> load() async {
    String data = await rootBundle.loadString(
        'assets/lang/${locale.languageCode}-${locale.countryCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    _sentences = {};
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  String trans(String key) {
    return _sentences[key];
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'fr',
        'de',
        'nl',
        'dk',
        'no',
        'pl',
        'it',
        'se',
        'zh',
        'si',
        'es',
        'id',
        'ar',
        'he'
      ].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) async {
// flutter 0.11 localeResolutionCallback fix, change it if fixed
    if (locale == null || isSupported(locale) == false) {
      debugPrint('*app_locale_delegate* fallback to locale ');

      locale = const Locale('en', 'US'); // fallback to default language
    }

    DemoLocalizations localizations = DemoLocalizations(locale);
    await localizations.load();

    debugPrint('Load ${locale.languageCode}-${locale.countryCode}');

    return localizations;
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
