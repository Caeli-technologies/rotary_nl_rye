import 'dart:convert';

import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/core/data/datasources/firestore.dart';
import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'datamodels/firestore_urls_model.dart';

class Repo {
  final ApiResponse apiResponse;
  final SharedPreferences cache;

  Repo({
    required this.apiResponse,
    required this.cache,
  });

  Future<void> initData() async {
    print("initData");
    print(cache.getKeys());
    if (!cache.getKeys().contains(Config.spImageHeaderKey) ||
        isTooOld(cache.getInt(Config.spLastUpdateKey)!)) {
      cacheData();
    }
  }

  Future<void> cacheData() async {
    cache.clear();
    cacheImageHeader();
    cacheNews();
    cacheExchangeStudents();
    cache.setInt(Config.spLastUpdateKey, DateTime.now().millisecondsSinceEpoch);
  }

  bool isTooOld(int milliSec) {
    final int hours = Config.hoursTillDataRefresh;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliSec);
    return dateTime.difference(DateTime.now()).inHours > hours;
  }

  Future<void> cacheImageHeader() async {
    final String url = await _getUrlFor(Config.spImageHeaderKey);

    cache.setString(Config.spImageHeaderKey, url);
  }

  Future<void> cacheNews() async {
    final String url = await _getUrlFor(Config.spNewsKey);
    final String data = await apiResponse.getBody(url);

    final List decoded = json.decode(data)[Config.apiNewsKey] as List;
    final List<News> news = [];
    for (Map<String, dynamic> item in decoded) {
      news.add(News.fromJson(item));
    }

    cache.setString(Config.spNewsKey, json.encode(news));
  }

  Future<void> cacheExchangeStudents() async {
    final String url = await _getUrlFor(Config.spExchangeStudentsKey);
    final String data = await apiResponse.getBody(url);

    final List decoded = json.decode(data)[Config.apiExchangeStudentsKey] as List;
    print(decoded);
    final List<ExchangeStudent> exchangeStudents = [];
    for (Map<String, dynamic> item in decoded) {
      exchangeStudents.add(ExchangeStudent.fromJson(item));
    }

    cache.setString(Config.spExchangeStudentsKey, json.encode(exchangeStudents));
  }

  Future<String> _getUrlFor(String key) async {
    final FireStoreUrlsModel object = await FireStoreUrls().getUrls();
    switch (key) {
      case "imageHeader":
        return object.headerUrl!;
      case "news":
        return object.jsonUrl!;
      case "exchangeStudents":
        return object.studentsUrl!;
      default:
        throw Exception("no such var");
    }
  }
}
