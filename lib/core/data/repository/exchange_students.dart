// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/core/data/datasources/firestore.dart';
import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/repository/exchange_student_repository.dart';
import '../initData.dart';

class ExchangeStudentsRepositoryImpl implements ExchangeStudentRepository {
  final _controller = StreamController<List<ExchangeStudent>>.broadcast();
  final Cache cache = new Cache();

  @override
  get exchangeStudents => _controller.stream;

  @override
  Future<void> dispose() async {
    await _controller.close();
  }

  Future<List<ExchangeStudent>> get() async {
    await Repo().initData('', '');

    List<ExchangeStudent> exchangeStudents = await getExchangeStudentsNews();
    _controller.sink.add(exchangeStudents);

    return exchangeStudents;
  }

  Future<List<ExchangeStudent>> getExchangeStudentsNews() async {
    final List temp = json.decode(await cache.getByKey(Config.spExchangeStudentsKey));
    final List<ExchangeStudent> exchangeStudents = [];
    temp.forEach((json) {exchangeStudents.add(ExchangeStudent.fromJson(json));});
    return exchangeStudents;
  }

  Future<void> cacheExchangeStudents() async {
    String data = await getExchangeStudentsData();

    List<ExchangeStudent> exchangeStudents = encodeExchangeStudents(data);

    await cache.store(
        Config.spExchangeStudentsKey, json.encode(exchangeStudents));
  }

  Future<String> getExchangeStudentsData() async {
    final ApiResponse apiResponse = new ApiResponse();
    final String url = await FireStoreUrls.getUrl(Config.fbExchangeStudentsKey);
    final String data = await apiResponse.getBody(url);
    return data;
  }

  List<ExchangeStudent> encodeExchangeStudents(String data) {
    final List decoded =
    json.decode(data)[Config.apiExchangeStudentsKey] as List;
    final List<ExchangeStudent> exchangeStudents = [];
    for (Map<String, dynamic> item in decoded) {
      exchangeStudents.add(ExchangeStudent.fromJson(item));
    }
    return exchangeStudents;
  }
}
