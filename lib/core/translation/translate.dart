import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:rotary_nl_rye/features/stories/presentation/widgets/lang.dart';
import 'package:translator/translator.dart';

class Translate {
  // TODO state emission
  static Future<Map<String, String>> translateMap(Map<String, String> toTranslate) async {
    if(!(await new DataConnectionChecker().hasConnection)){
      print("No connection");
      return toTranslate;
    }

    final Map<String, String> result = {};

    final List keys = toTranslate.keys.toList();
    final List values = toTranslate.values.toList();

    for (int i = 0; i < toTranslate.length; i++){
      result[keys[i]] = await translateText(values[i]);
    }

    return result;
  }

  static String fetchLang() {
    if (Platform.localeName.split('_')[0] == 'zh') {
      return 'zh-cn';
    } else {
      return Platform.localeName.split('_')[0];
    }
  }

  static Future<String> translateText(String inputText) async {
    final lang = fetchLang();
    final translator = GoogleTranslator();

    if (supportedLangs.containsValue(lang)) {
      var translated =
          await translator.translate(inputText, to: "$lang");

      return translated.text;
    }

    // fallback to english
    print("Language not supported. Fallback to english");
    var translated = await translator.translate(inputText, to: "en");
    return translated.text;
  }
}
