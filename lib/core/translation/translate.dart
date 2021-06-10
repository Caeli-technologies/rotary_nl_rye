import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rotary_nl_rye/core/translation/deeplSupportedLang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Translate {
  static Future<String> text(String inputText) async {
    // check network connection
    if (!(await new InternetConnectionChecker().hasConnection)) {
      print("No connection");
      return inputText;
    }

    var lang = fetchLang();

    // check cache
    SharedPreferences cache = await SharedPreferences.getInstance();
    final key = lang + "+" + inputText;
    if(cache.containsKey(key)){
      print("Retrieving from cache");
      return Future.value(cache.getString(key));
    }

    // fallback to english
    if (!(deeplSupportedLangs.containsValue(lang))) {
      print("Language not supported. Fallback to english");
      lang = "EN-US";
    }

    print("Retrieving from deepl api and cache data");
    final response = await getTranslation(lang, inputText);
    final body = jsonDecode(response.body);
    final result = body['translations'][0]['text'];

    cache.setString(key, result);

    return result;
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

  static String fetchLang() {
    if (Platform.localeName.split('_')[0] == 'zh') {
      return 'ZH';
    } else {
      return Platform.localeName.split('_').join('-').toUpperCase();
    }
  }
}
