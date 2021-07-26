import 'dart:async';
import 'dart:convert';

import 'package:rotary_nl_rye/core/data/datasources/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/entities/story.dart';
import 'package:rotary_nl_rye/core/domain/repository/stories_repository.dart';

import '../initData.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  final _controller = StreamController<List<Story>>.broadcast();
  final Cache cache = new Cache();

  @override
  getStoriesOf(ExchangeStudent exchangeStudent) => _controller.stream;

  @override
  Future<void> dispose() async {
    await _controller.close();
  }

  Future<List<Story>> get(String studentExchangeYear, String studentName) async {
    await Repo().initData(studentExchangeYear, studentName);

    List<Story> stories = await getCachedStories(studentExchangeYear, studentName);
    _controller.sink.add(stories);

    return stories;
  }

  Future<void> cacheStories(String studentExchangeYear, String studentName) async {
    String data = await getStoriesData(studentExchangeYear, studentName);

    List<Story> stories = encodeStories(data);

    await cache.store(studentExchangeYear + studentName, json.encode(stories));
  }

  Future<List<Story>> getCachedStories(String studentExchangeYear, String studentName) async {
    final List temp = json.decode(await cache.getByKey(studentExchangeYear + studentName));
    final List<Story> stories = [];
    temp.forEach((json) {
      stories.add(Story.fromJson(json));
    });
    return stories;
  }

  Future<String> getStoriesData(String studentExchangeYear, String studentName) async {
    final ApiResponse apiResponse = new ApiResponse();
    final String url = "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rebounds/students/$studentExchangeYear/${studentName.replaceAll(" ","_").toLowerCase()}.json";
    final String data = await apiResponse.getBody(url);
    return data;
  }

  List<Story> encodeStories(String data) {
    final List decoded = json.decode(data)["stories"] as List;
    final List<Story> stories = [];
    for (Map<String, dynamic> item in decoded) {
      stories.add(Story.fromJson(item));
    }
    return stories;
  }
}
