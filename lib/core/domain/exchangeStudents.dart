// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/caching/shared_preferences_cache.dart';
import 'package:rotary_nl_rye/core/domain/repository/exchange_student_repository.dart';
import 'package:rotary_nl_rye/core/domain/repository/stories_repository.dart';
import 'entities/exchange_student.dart';
import 'entities/story.dart';

class StudentsBloc {
  final StoriesRepository storiesRepository;
  final ExchangeStudentRepository exchangeStudentRepository;

  StudentsBloc(this.storiesRepository, this.exchangeStudentRepository);

  final _studentController =
      StreamController<List<ExchangeStudent>>.broadcast();
  final _storyController = StreamController<List<Story>>.broadcast();

  get studentList => _studentController.stream;
  get storyList => _storyController.stream;

  final SharedPreferencesCache cache = new SharedPreferencesCache();

  void getExchangeStudentList() async {
    final List<ExchangeStudent>? exchangeStudents = await exchangeStudentRepository.exchangeStudents;
    if (exchangeStudents == null) {
      return;
    }
    _studentController.sink.add(exchangeStudents);
  }

  void getStoriesList(String studentExchangeYear, String studentName) async {
    final List<Story>? stories = await storiesRepository.getStories(studentExchangeYear, studentName);
    if (stories == null) {
      return;
    }
    _storyController.sink.add(stories);
  }

  disposeStudent() {
    _studentController.close();
  }

  disposeStory() {
    _storyController.close();
  }
}
