import 'dart:convert';

import 'package:rotary_nl_rye/core/data/datasources/firestore.dart';
import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'datamodels/firestore_urls_model.dart';

class Repo {
  final FireStoreUrls fireStoreUrls;
  final ApiResponse apiResponse;
  final SharedPreferences cache;

  Repo({
    required this.fireStoreUrls,
    required this.apiResponse,
    required this.cache,
  });

  Future<void> initData() async {
    if (cache.getKeys().length == 0 ||
        isTooOld(cache.getInt("creationTime")!)) {
      cacheData();
    }
  }

  Future<void> cacheData() async {
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
    final String data = await apiResponse.getBody(url);

    cache.setString("imageHeader", data);
  }

  Future<void> cacheNews() async {
    final String url = await _getUrlFor("news");
    final String data = await apiResponse.getBody(url);

    final List decoded = json.decode(data);
    final List<News> news = [];
    for (var item in decoded) {
      news.add(News.fromJson(item));
    }

    cache.setString("news", news.toString());
  }

  Future<void> cacheExchangeStudents() async {
    final String url = await _getUrlFor("exchangeStudents");
    final String data = await apiResponse.getBody(url);

    final List decoded = json.decode(data);
    final List<ExchangeStudent> news = [];
    for (var item in decoded) {
      news.add(ExchangeStudent.fromJson(item));
    }

    cache.setString("exchangeStudents", data);
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
