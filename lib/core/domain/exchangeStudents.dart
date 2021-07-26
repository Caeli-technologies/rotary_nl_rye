import 'dart:async';
import 'dart:convert';

import 'package:rotary_nl_rye/core/data/datasources/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/core/data/initData.dart';

import 'entities/exchange_student.dart';
import 'entities/story.dart';

class StudentsBloc {
  final _studentController =
      StreamController<List<ExchangeStudent>>.broadcast();
  final _storyController = StreamController<List<Story>>.broadcast();

  get studentList => _studentController.stream;
  get storyList => _storyController.stream;

  final Cache cache = new Cache();

  void getExchangeStudentList() async {
    await Repo().initData("", "");
    final List temp = json.decode(await cache.getByKey(Config.spExchangeStudentsKey)) as List;
    final List<ExchangeStudent> exchangeStudents = [];
    temp.forEach((json) {exchangeStudents.add(ExchangeStudent.fromJson(json));});
    _studentController.sink.add(exchangeStudents);
  }

  void getStoriesList(String studentExchangeYear, String studentName) async {
    await Repo().initData(studentExchangeYear, studentName);
    final List temp = json.decode(await cache.getByKey(studentExchangeYear + studentName)) as List;
    final List<Story> stories = [];
    temp.forEach((json) {stories.add(Story.fromJson(json));});
    _storyController.sink.add(stories);
  }

  disposeStudent() {
    _studentController.close();
  }

  disposeStory() {
    _storyController.close();
  }
}
