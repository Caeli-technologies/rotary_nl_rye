import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiResponse {
  Future<String> getBody(String url) async {
    http.Response? response;
    try {
      response = await http.get(
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
print(json.decode(response.body));
    return response.body;
  }
}