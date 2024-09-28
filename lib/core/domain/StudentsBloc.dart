// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'entities/exchange_student.dart';

class StudentsBloc {
  final _studentListController = StreamController<List<ExchangeStudent>>();

  Stream<List<ExchangeStudent>> get studentList =>
      _studentListController.stream;

  Future<void> getExchangeStudentList() async {
    final data = await rootBundle.loadString('assets/students/list.json');
    final jsonResult = jsonDecode(data)['list'] as Map<String, dynamic>;

    final students = <ExchangeStudent>[];
    for (var yearList in jsonResult.values) {
      for (var item in yearList) {
        students.add(ExchangeStudent.fromJson(item));
      }
    }
    _studentListController.sink.add(students);
  }

  void dispose() {
    _studentListController.close();
  }
}
