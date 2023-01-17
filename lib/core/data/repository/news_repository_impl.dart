// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/caching/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/data/datasources/url_provider.dart';
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
import 'package:rotary_nl_rye/core/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final Cache cache;

  NewsRepositoryImpl(this.cache);

  @override
  Future<List<News>?> get news async{
    String? rawData =
    await _getNewsDataLocal();
    if (rawData == null) {
      rawData = await _getNewsDataRemote();
      if (rawData == null) {
        return null;
      }
      await _cacheNews(rawData);
    }
    return _parseRaw(rawData);
  }

  Future<String?> _getNewsDataRemote() async {
    return ApiResponse.getContent(await UrlProvider.getNewsUrl());
  }

  Future<String?> _getNewsDataLocal() async {
    return await cache.getByKey(Config.spNewsKey);
  }

  Future<void> _cacheNews(final String news) async {
    await cache.store(Config.spNewsKey, news);
  }

  List<News> _parseRaw(final String rawData) {
    final List decoded = json.decode(rawData)[Config.apiNewsKey] as List;
    final List<News> news = [];
    for (Map<String, dynamic> item in decoded) {
      news.add(News.fromJson(item));
    }
    return news;
  }
}
