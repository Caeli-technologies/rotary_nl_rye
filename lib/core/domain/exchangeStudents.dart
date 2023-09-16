// 🎯 Dart imports:
import 'dart:async';
import 'dart:convert';

// 🌎 Project imports:
import 'package:flutter/services.dart';
import 'entities/exchange_student.dart';

class StudentsBloc {
  final _studentListController = StreamController<List<ExchangeStudent>>();

  Stream<List<ExchangeStudent>> get studentList =>
      _studentListController.stream;
  Future<void> getExchangeStudentList() async {
    String data = await rootBundle.loadString('assets/students/list.json');
    Map<String, dynamic> jsonResult = jsonDecode(data)['list'];

    List<ExchangeStudent> students = [];

    // Loop through each year's list
    for (var yearList in jsonResult.values) {
      // Loop through each student in the year's list
      for (var item in yearList) {
        students.add(ExchangeStudent.fromJson(item));
      }
    }

    _studentListController.sink.add(students);
  }

  void disposeStudent() {
    _studentListController.close();
  }
}
