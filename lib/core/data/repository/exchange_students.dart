// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/caching/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/core/data/datasources/url_provider.dart';
import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/repository/exchange_student_repository.dart';

class ExchangeStudentsRepositoryImpl implements ExchangeStudentRepository {
  final Cache cache;

  ExchangeStudentsRepositoryImpl(this.cache);

  @override
  Future<List<ExchangeStudent>?> get exchangeStudents async {
    String? rawData = await _getExchangeStudentsDataLocal();
    if (rawData == null) {
      rawData = await _getExchangeStudentsDataRemote();
      if (rawData == null) {
        return null;
      }
      await _cacheExchangeStudents(rawData);
    }
    return _parseRaw(rawData);
  }

  Future<String?> _getExchangeStudentsDataRemote() async {
    return await ApiResponse.getContent(
        await UrlProvider.getExchangeStudentUrl());
  }

  Future<String?> _getExchangeStudentsDataLocal() async {
    return await cache.getByKey(Config.spExchangeStudentsKey);
  }

  Future<void> _cacheExchangeStudents(final String students) async {
    await cache.store(Config.spExchangeStudentsKey, students);
  }

  List<ExchangeStudent> _parseRaw(final String rawData) {
    final List decoded = json.decode(rawData)[Config.apiExchangeStudentsKey];
    final List<ExchangeStudent> exchangeStudents = [];
    for (var item in decoded) {
      exchangeStudents.add(ExchangeStudent.fromJson(item));
    }
    return exchangeStudents;
  }
}
