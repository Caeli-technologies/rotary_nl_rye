import 'dart:async';

import 'package:rotary_nl_rye/core/domain/entities/news.dart';

abstract class NewsRepository {
  Stream<List<News>> get news;

  Future<void> dispose();
}