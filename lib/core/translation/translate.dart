import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rotary_nl_rye/core/translation/deeplSupportedLang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Translate {
  static Future<Map<String, dynamic>> text(
      {required String inputText, String inputLang = 'NL'}) async {
    Map<String, dynamic> result = {
      'translation': '',
      'success': false,
      'message': ''
    };

    var lang = fetchLang();

    // check if input lang is different from the text
    if (lang == inputLang) {
      result['translation'] = inputLang;
      result['message'] = 'Text lang = to Translate lang';

      return result;
    }

    print('Translating');

    // check cache
    SharedPreferences cache = await SharedPreferences.getInstance();
    final key = lang + '+' + inputText;
    if (cache.containsKey(key)) {
      print('Retrieving from cache');
      result['translation'] = Future.value(cache.getString(key));
      result['success'] = true;

      return result;
    }

    // check network connection
    if (!(await new InternetConnectionChecker().hasConnection)) {
      result['translation'] = inputLang;
      result['message'] = 'No connection';
      result['success'] = false;

      return result;
    }

    // fallback to english
    if (!(deeplSupportedLangs.containsValue(lang))) {
      print('Language not supported. Fallback to english');
      lang = 'EN-US';
    }

    print('Retrieving from deepl api');
    final response = await getTranslation(lang, inputText);
    final status = response.statusCode;

    // check if api call was succes
    if (status != 200) {
      result['translation'] = inputText;
      result['message'] = 'Api call failed with status: $status';

      return result;
    }

    final body = jsonDecode(response.body);
    result['translation'] = body['translations'][0]['text'];
    result['success'] = true;

    print('Cache data');
    cache.setString(key, result['translation']);

    return result;
  }

  static Future<http.Response> getTranslation(String lang, String input) async {
    String data = await rootBundle.loadString('assets/keys/deepl.json');
    String key = json.decode(data)['key'];
    return http.post(
        Uri.parse('https://api-free.deepl.com/v2/translate?auth_key=$key'),
        headers: <String, String>{
          'Host': 'api-free.deepl.com',
        },
        body: <String, String>{
          'text': input,
          'target_lang': lang
        });
  }

  static String fetchLang() {
    if (Platform.localeName.split('_')[0] == 'zh') {
      return 'ZH';
    } else {
      return Platform.localeName.split('_').join('-').toUpperCase();
    }
  }
}
