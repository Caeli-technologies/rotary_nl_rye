import 'dart:async';

import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/entities/story.dart';

abstract class StoriesRepository {
  Stream<List<Story>> getStoriesOf(ExchangeStudent exchangeStudent);

  Future<void> dispose();
}