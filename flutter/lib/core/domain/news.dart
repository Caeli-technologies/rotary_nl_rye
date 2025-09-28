// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'entities/news.dart';

class NewsBloc {
  final _newsController = StreamController<List<News>>.broadcast();
  final Dio _dio = Dio(); // Create an instance of Dio

  get news => _newsController.stream;

  final String url =
      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/news/news.json';

  Future<List<News>> getNewsData() async {
    try {
      // Fetch the news data from the URL using Dio
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        // Decode the response as a Map
        final Map<String, dynamic> jsonResponse = response.data;

        // Access the 'news' field which contains the list of news items
        final List<dynamic> newsList = jsonResponse['news'];

        // Convert the list to List<News> using the News model
        final List<News> news =
            newsList.map((json) => News.fromJson(json)).toList();

        _newsController.sink.add(news);

        return news;
      } else {
        throw Exception('Failed to load news data');
      }
    } catch (e) {
      // Handle errors and optionally add logging here
      print('Error fetching news data: $e');
      _newsController.sink.addError(e);
      return [];
    }
  }

  Future<void> dispose() async {
    await _newsController.close();
  }
}
