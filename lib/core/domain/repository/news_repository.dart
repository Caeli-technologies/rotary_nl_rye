// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/news.dart';

abstract class NewsRepository {
  Future<List<News>?> get news;
}
