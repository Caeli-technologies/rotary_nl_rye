import 'dart:async';
import 'dart:convert';

import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entities/exchange_student.dart';

class StudentsBloc {
  final _studentController =
      StreamController<List<ExchangeStudent>>.broadcast();
  final _storyController = StreamController<List<Story>>.broadcast();

  get studentList => _studentController.stream;
  get storyList => _storyController.stream;

  void getExchangeStudentList() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    /*await Repo(apiResponse: ApiResponse(), cache: cache).initData();
    final List<Story> story = cache.getString("imageHeader") as List<Story>;
    _storyController.sink.add(story);*/

    final List temp = json.decode(cache.getString(Config.spExchangeStudentsKey)!) as List;
    final List<ExchangeStudent> exchangeStudents = [];
    temp.forEach((json) {exchangeStudents.add(ExchangeStudent.fromJson(json));});
    _studentController.sink.add(exchangeStudents);
  }

  disposeStudent() {
    _studentController.close();
  }

  disposeStory() {
    _storyController.close();
  }
}
