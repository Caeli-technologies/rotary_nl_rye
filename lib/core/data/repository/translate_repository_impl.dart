// 🎯 Dart imports:
import 'dart:convert';
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import '../../domain/repository/translate_repository.dart';
import '../datasources/caching/cache.dart';
import '../network/network_info.dart';
import '../translation/deeplSupportedLang.dart';

class TranslateRepositoryImpl implements TranslateRepository {
  final Cache cache;
  final NetworkInfo networkInfo;

  TranslateRepositoryImpl(this.cache, this.networkInfo);

  @override
  Future<String?> getTranslation(String text, {Locale? sourceLang, Locale? targetLang}) async {
    final hashCodeOfText = text.hashCode.toString();

    final cachedTranslation = await cache.getByKey(hashCodeOfText);
    if (cachedTranslation != null) {
      return cachedTranslation;
    }

    String key = await _getApiKey();

    if (await networkInfo.isConnected) {
      final response = await http.post(
          Uri.parse('https://api-free.deepl.com/v2/translate?auth_key=$key'),
          headers: <String, String>{
            'Host': 'api-free.deepl.com',
          },
          body: <String, String>{
            'text': text,
            'source_lang': _getSourceLanguageString(sourceLang),
            'target_lang': _getTargetLanguageString(targetLang)
          });

      final status = response.statusCode;

      // check if api call was successful
      if (status != 200) {
        return null;
      }

      final body = jsonDecode(response.body);
      final translation = body['translations'][0]['text'];

      cache.store(hashCodeOfText, translation);

      return translation;
    }

    return null;
  }

  Future<String> _getApiKey() async {
    String data = await rootBundle.loadString('assets/keys/deepl.json');
    return json.decode(data)['key'];
  }

  String _getTargetLanguageString(Locale? locale) {
    if (locale == null) {
      return 'EN';
    }
    if (locale.countryCode != null && deeplTargetLanguages.containsValue(locale.countryCode! + '-' + locale.languageCode)) {
      return (locale.countryCode! + '-' + locale.languageCode).toUpperCase();
    }
    if (locale.countryCode != null && deeplTargetLanguages.containsValue(locale.countryCode!)) {
      return locale.countryCode!.toUpperCase();
    }
    return 'EN';
  }

  String _getSourceLanguageString(Locale? locale) {
    if (locale == null) {
      return 'NL';
    }
    if (locale.countryCode != null && deeplSourceLanguages.containsValue(locale.countryCode! + '-' + locale.languageCode)) {
      return (locale.countryCode! + '-' + locale.languageCode).toUpperCase();
    }
    if (locale.countryCode != null && deeplSourceLanguages.containsValue(locale.countryCode!)) {
      return locale.countryCode!.toUpperCase();
    }
    return 'NL';
  }
}
