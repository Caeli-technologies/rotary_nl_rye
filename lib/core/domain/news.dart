// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/core/data/initData.dart';
import 'entities/news.dart';

class NewsBloc {
  final _headerController = StreamController<String>.broadcast();
  final _newsController = StreamController<List<News>>.broadcast();

  final Cache cache = new Cache();

  get header => _headerController.stream;
  get news => _newsController.stream;

  Future<List<News>> getNewsData() async {
    await Repo().initData('', '');
    final String imageHeader = await cache.getByKey(Config.spImageHeaderKey);
    _headerController.sink.add(imageHeader);

    final List temp = json.decode(await cache.getByKey(Config.spNewsKey));
    final List<News> news = [];
    temp.forEach((json) {news.add(News.fromJson(json));});
    _newsController.sink.add(news);

    return news;
  }

  Future<void> dispose() async {
    await _newsController.close();
    await _headerController.close();
  }
}
