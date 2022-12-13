// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/entities/story.dart';

abstract class StoriesRepository {
  Future<List<Story>?> getStories(
      String studentExchangeYear, String studentName);
}
