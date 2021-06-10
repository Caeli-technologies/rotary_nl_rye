import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rotary_nl_rye/core/translation/deeplSupportedLang.dart';

class Translate {
  // TODO state emission
  static Future<Map<String, String>> translateMap(
      Map<String, String> toTranslate) async {
    if (!(await new InternetConnectionChecker().hasConnection)) {
      print("No connection");
      return toTranslate;
    }

    final Map<String, String> result = {};

    final List keys = toTranslate.keys.toList();
    final List values = toTranslate.values.toList();

    for (int i = 0; i < toTranslate.length; i++) {
      result[keys[i]] = await translateText(values[i]);
    }

    return result;
  }

  static String fetchLang() {
    if (Platform.localeName.split('_')[0] == 'zh') {
      return 'ZH';
    } else {
      return Platform.localeName.split('_').join('-').toUpperCase();
    }
  }

  static Future<String> translateText(String inputText) async {
    final lang = fetchLang();

    if (deeplSupportedLangs.containsValue(lang)) {
      final response = await getTranslation(lang, inputText);
      final body = jsonDecode(response.body);

      return body['translations'][0]['text'];
    }

    // fallback to english
    print("Language not supported. Fallback to english");
    final response = await getTranslation('EN-US', inputText);
    final body = jsonDecode(response.body);

    return body['translations'][0]['text'];
  }

  static Future<http.Response> getTranslation(String lang, String input) async {
    String data = await rootBundle.loadString('assets/keys/deepl.json');
    String key = json.decode(data)['key'];
    return http.post(Uri.parse('https://api-free.deepl.com/v2/translate?auth_key=$key'), headers: <String, String>{
      'Host': 'api-free.deepl.com',
    }, body: <String, String>{
      'text': input,
      'target_lang': lang
    });
  }
}
