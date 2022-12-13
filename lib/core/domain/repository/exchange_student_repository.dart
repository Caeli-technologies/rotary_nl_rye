// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';

abstract class ExchangeStudentRepository {
  Future<List<ExchangeStudent>?> get exchangeStudents;
}
