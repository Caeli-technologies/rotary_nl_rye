// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/caching/shared_preferences_cache.dart';
import 'package:rotary_nl_rye/core/domain/repository/news_repository.dart';
import 'entities/news.dart';

class NewsBloc {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository);

  final _headerController = StreamController<String>.broadcast();
  final _newsController = StreamController<List<News>>.broadcast();

  final SharedPreferencesCache cache = new SharedPreferencesCache();

  get header => _headerController.stream;
  get news => _newsController.stream;

  void getNewsData() async {
    final List<News>? news = await newsRepository.news;
    if (news == null) {
      return;
    }
    _newsController.sink.add(news);
  }

  Future<void> dispose() async {
    await _newsController.close();
    await _headerController.close();
  }
}
