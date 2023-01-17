// 🎯 Dart imports:
import 'dart:typed_data';

// 📦 Package imports:
import 'package:http/http.dart';

class ApiResponse {
  static Future<String> getContent(String url) async {
    return (await _getResponse(url)).body;
  }

  static Future<Uint8List> getFileContent(String url) async {
    return (await _getResponse(url)).bodyBytes;
  }

  static Future<Response> _getResponse(final String url) async {
    final Response? response;
    try {
      response = await get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      throw Exception('unable to fetch from url $e');
    }

    if (response.statusCode != 200) {
      throw 'response ${response.statusCode}';
    }

    return response;
  }
}
