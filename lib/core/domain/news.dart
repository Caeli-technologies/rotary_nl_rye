import 'dart:async';
import 'dart:convert';

import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/data/initData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entities/news.dart';

class NewsBloc {
  final _headerController = StreamController<String>.broadcast();
  final _newsController = StreamController<List<News>>.broadcast();

  get header => _headerController.stream;
  get news => _newsController.stream;

  Future<List<News>> getNewsData() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    await Repo(apiResponse: ApiResponse(), cache: cache).initData();
    final String imageHeader = cache.getString("imageHeader")!;
    _headerController.sink.add(imageHeader);

    final List temp = json.decode(cache.getString("news")!) as List;
    final List<News> news = [];
    temp.forEach((json) {news.add(News.fromJson(json));});
    _newsController.sink.add(news);

    return news;
  }

  dispose() {
    _newsController.close();
    _headerController.close();
  }
}