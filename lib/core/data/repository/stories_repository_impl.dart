// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/caching/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/url_provider.dart';
import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/domain/entities/story.dart';
import 'package:rotary_nl_rye/core/domain/repository/stories_repository.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  final Cache cache;

  StoriesRepositoryImpl(this.cache);

  @override
  Future<List<Story>?> getStories(
      String studentExchangeYear, String studentName) async {
    String? rawData =
        await _getStoriesDataLocal(studentExchangeYear, studentName);
    if (rawData == null) {
      rawData = await _getStoriesDataRemote(studentExchangeYear, studentName);
      if (rawData == null) {
        return null;
      }
      await _cacheStories(studentExchangeYear, studentName, rawData);
    }
    return _parseRaw(rawData);
  }

  Future<String?> _getStoriesDataRemote(
      String studentExchangeYear, String studentName) async {
    return await ApiResponse.getContent(
        UrlProvider.getStoriesUrl(studentExchangeYear, studentName));
  }

  Future<String?> _getStoriesDataLocal(
      String studentExchangeYear, String studentName) async {
    return await cache.getByKey(studentExchangeYear + studentName);
  }

  Future<void> _cacheStories(
      String studentExchangeYear, String studentName, String stories) async {
    await cache.store(studentExchangeYear + studentName, stories);
  }

  List<Story> _parseRaw(final String rawData) {
    final List decoded = json.decode(rawData)['stories'];
    final List<Story> stories = [];
    for (var item in decoded) {
      stories.add(Story.fromJson(item));
    }
    return stories;
  }
}
