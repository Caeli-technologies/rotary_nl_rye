// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/core/data/datasources/firestore.dart';
import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
import 'package:rotary_nl_rye/core/domain/repository/news_repository.dart';
import '../initData.dart';

class NewsRepositoryImpl implements NewsRepository {
  final _controller = StreamController<List<News>>.broadcast();
  final Cache cache = new Cache();

  @override
  get news => _controller.stream;

  @override
  Future<void> dispose() async {
    await _controller.close();
  }

  Future<List<News>> get() async {
    await Repo().initData('', '');

    List<News> news = await getCachedNews();
    _controller.sink.add(news);

    return news;
  }

  Future<List<News>> getCachedNews() async {
    final List temp = json.decode(await cache.getByKey(Config.spNewsKey));
    final List<News> news = [];
    temp.forEach((json) {news.add(News.fromJson(json));});
    return news;
  }

  Future<void> cacheNews() async {
    String data = await getNewsData();

    List<News> news = encodeNews(data);

    await cache.store(Config.spNewsKey, json.encode(news));
  }

  Future<String> getNewsData() async {
    final ApiResponse apiResponse = new ApiResponse();
    final String url = await FireStoreUrls.getUrl(Config.fbNewsKey);
    final String data = await apiResponse.getBody(url);
    return data;
  }

  List<News> encodeNews(String data) {
    final List decoded = json.decode(data)[Config.apiNewsKey] as List;
    final List<News> news = [];
    for (Map<String, dynamic> item in decoded) {
      news.add(News.fromJson(item));
    }
    return news;
  }
}
