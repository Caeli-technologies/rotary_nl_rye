// 🎯 Dart imports:
import 'dart:convert';
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/translation/deeplSupportedLang.dart';

class Translate {
  static final Dio _dio = Dio(); // Initialize Dio

  static Future<Map<String, dynamic>> text({
    required String inputText,
    String inputLang = 'NL',
  }) async {
    Map<String, dynamic> result = {
      'translation': inputText, // Fallback to the input text
      'success': false,
      'message': '',
    };

    String lang = fetchLang();

    // Check if the input language matches the translation language
    if (lang == inputLang) {
      result['message'] = 'Text language is the same as the target language';
      result['success'] = true;
      return result;
    }

    print('Translating...');

    // Check cache for the translation
    SharedPreferences cache = await SharedPreferences.getInstance();
    final key = '$lang+$inputText';

    if (cache.containsKey(key)) {
      print('Retrieving translation from cache');
      result['translation'] = cache.getString(key)!;
      result['success'] = true;
      return result;
    }

    // Check internet connection
    if (!(await InternetConnectionChecker().hasConnection)) {
      result['message'] = 'No internet connection';
      return result;
    }

    // Fallback to English if the language is not supported by DeepL
    if (!deeplSupportedLangs.containsValue(lang)) {
      print('Language not supported, falling back to English');
      lang = 'EN-US';
    }

    // Fetch translation from DeepL API using Dio
    print('Fetching translation from DeepL API...');
    final response = await getTranslation(lang, inputText);

    if (response.statusCode != 200) {
      result['message'] = 'API call failed with status: ${response.statusCode}';
      return result;
    }

    try {
      final body = jsonDecode(response.data);
      final translation = body['translations'][0]['text'];
      result['translation'] = translation;
      result['success'] = true;

      // Cache the translation
      print('Caching translation...');
      cache.setString(key, translation);
    } catch (e) {
      print('Error parsing translation response: $e');
      result['message'] = 'Error parsing translation response';
    }

    return result;
  }

  static Future<Response> getTranslation(String lang, String input) async {
    String data = await rootBundle.loadString('assets/keys/deepl.json');
    String key = json.decode(data)['key'];

    return _dio.post(
      'https://api-free.deepl.com/v2/translate',
      options: Options(
        headers: {'Host': 'api-free.deepl.com'},
      ),
      data: {
        'text': input,
        'target_lang': lang,
        'auth_key': key,
      },
    );
  }

  static String fetchLang() {
    String locale = Platform.localeName.split('_')[0];
    return locale == 'zh'
        ? 'ZH'
        : Platform.localeName.split('_').join('-').toUpperCase();
  }
}
