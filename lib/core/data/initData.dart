import 'dart:convert';

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
    if (!cache.getKeys().contains("imageHeader") ||
        isTooOld(cache.getInt("creationTime")!)) {
      cacheData();
    }
  }

  Future<void> cacheData() async {
    cache.clear();
    cacheImageHeader();
    cacheNews();
    cacheExchangeStudents();
    cache.setInt("creationTime", DateTime.now().millisecondsSinceEpoch);
  }

  bool isTooOld(int milliSec) {
    final int hours = 48;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliSec);
    return dateTime.difference(DateTime.now()).inHours > hours;
  }

  Future<void> cacheImageHeader() async {
    final String url = await _getUrlFor("imageHeader");

    cache.setString("imageHeader", url);
  }

  Future<void> cacheNews() async {
    final String url = await _getUrlFor("news");
    final String data = await apiResponse.getBody(url);

    final List decoded = json.decode(data)["news"] as List;
    final List<News> news = [];
    for (Map<String, dynamic> item in decoded) {
      news.add(News.fromJson(item));
    }

    cache.setString("news", json.encode(news));
  }

  Future<void> cacheExchangeStudents() async {
    final String url = await _getUrlFor("exchangeStudents");
    final String data = await apiResponse.getBody(url);

    final List decoded = json.decode(data)["rebounds"] as List;
    print(decoded);
    final List<ExchangeStudent> exchangeStudents = [];
    for (Map<String, dynamic> item in decoded) {
      exchangeStudents.add(ExchangeStudent.fromJson(item));
    }

    cache.setString("exchangeStudents", json.encode(exchangeStudents));
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
