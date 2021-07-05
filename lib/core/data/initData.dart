import 'dart:convert';

import 'package:rotary_nl_rye/core/data/datasources/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/core/data/datasources/firestore.dart';
import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/entities/news.dart';

class Repo {
  final ApiResponse apiResponse = new ApiResponse();
  final Cache cache = new Cache();

  Future<void> initData() async {
    print("initData");
    if (!(await isDataPresent()) || await isTooOld()) {
      await cacheData();
    }
  }

  Future<void> cacheData() async {
    await cache.clear();
    await cacheImageHeader();
    await cacheNews();
    await cacheExchangeStudents();
    await cache.store(Config.spLastUpdateKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> isDataPresent() async {
    final Set<String> keys = await cache.getKeys();
    return keys.contains(Config.spLastUpdateKey);
  }

  Future<bool> isTooOld() async {
    DateTime dateTime = await getLastUpdate();
    final age = dateTime.difference(DateTime.now());
    return age > Config.maxAge;
  }

  Future<DateTime> getLastUpdate() async {
    final int lastUpdate = await cache.getByKey(Config.spLastUpdateKey) as int;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(lastUpdate);
    return dateTime;
  }

  Future<void> cacheImageHeader() async {
    final String url = await FireStoreUrls.getUrl(Config.fbImageHeaderKey);

    await cache.store(Config.spImageHeaderKey, url);
  }

  Future<void> cacheNews() async {
    final String url = await FireStoreUrls.getUrl(Config.fbNewsKey);
    final String data = await apiResponse.getBody(url);

    final List decoded = json.decode(data)[Config.apiNewsKey] as List;
    final List<News> news = [];
    for (Map<String, dynamic> item in decoded) {
      news.add(News.fromJson(item));
    }

    await cache.store(Config.spNewsKey, json.encode(news));
  }

  Future<void> cacheExchangeStudents() async {
    final String url = await FireStoreUrls.getUrl(Config.fbExchangeStudentsKey);
    final String data = await apiResponse.getBody(url);

    final List decoded =
        json.decode(data)[Config.apiExchangeStudentsKey] as List;
    print(decoded);
    final List<ExchangeStudent> exchangeStudents = [];
    for (Map<String, dynamic> item in decoded) {
      exchangeStudents.add(ExchangeStudent.fromJson(item));
    }

    await cache.store(
        Config.spExchangeStudentsKey, json.encode(exchangeStudents));
  }
}
