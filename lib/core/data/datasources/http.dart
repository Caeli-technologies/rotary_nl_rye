// 📦 Package imports:
import 'package:dio/dio.dart';

class ApiResponse {
  final Dio _dio = Dio();

  Future<String> getBody(String url) async {
    Response<String>? response;

    try {
      // Send GET request using Dio
      response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      // Handle Dio-specific exceptions
      throw Exception('Unable to fetch from url: $e');
    }

    if (response.statusCode != 200) {
      throw Exception('Error: Response status code ${response.statusCode}');
    }

    return response.data ?? '';
  }
}
