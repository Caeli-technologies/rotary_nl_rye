import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations? of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  late Map<String, String> _sentences;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('assets/lang/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = new Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });

    return true;
  }

  String trans(String key) {
    return this._sentences[key]!;
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'de',
        'nl',
        'pt',
        'zh',
        'es',
      ].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) async {
// flutter 0.11 localeResolutionCallback fix, change it if fixed
    if (isSupported(locale) == false) {
      print('*app_locale_delegate* fallback to locale ');

      locale = Locale('en', ''); // fallback to default language
    }

    DemoLocalizations localizations = new DemoLocalizations(locale);
    await localizations.load();

    if (kDebugMode) {
      log('Load ${locale.languageCode}');
      log('Platform.localeName: ' + Platform.localeName.substring(0, 2));
    }

    return localizations;
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
