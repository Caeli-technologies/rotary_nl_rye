import 'dart:async';

import 'package:rotary_nl_rye/core/bloc/repository.dart';
import 'package:rotary_nl_rye/features/news/models/news.dart';
import 'package:rotary_nl_rye/features/stories/models/exchange_student.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsController = StreamController<List<News>>.broadcast();

  get news => _newsController.stream;
  final _headerController = StreamController<String>.broadcast();

  get header => _headerController.stream;

  NewsBloc() {
    getNews();
  }

  Future<List<News>> getNews() async {
    var x = await _repository.fetchNews();
    print('get news ${x.toString()}');
    _newsController.sink.add(x);
    print('newscontroller.sink.add');
    var y = await _repository.fetchHeader();
    //print('get header ${y.toString()}');
    _headerController.sink.add(y);
    //print('_headercontroller.sink.add');
    return x;
  }

  dispose() {
    _newsController.close();
    _headerController.close();
  }
// Stream<List<News>> get allNews => _newsFetcher.stream;
// fetchAllNews() async {
//   List<News> news = await _repository.fetchNews();
//   _newsFetcher.sink.add(news);
// }
//
// dispose() {
//   _newsFetcher.close();
// }
}

class StudentsBloc {
  final _repository = Repository();
  final _studentController =
      StreamController<List<ExchangeStudent>>.broadcast();

  get studentList => _studentController.stream;
  final _storyController = StreamController<List<Story>>.broadcast();

  get storyList => _storyController.stream;

  getStudentList() async {
    var x = await _repository.fetchStudentList();
    //print('get studentList ${x.toString()}');
    _studentController.sink.add(x);
    //print('studentcontroller.sink.add');
  }

  getStoryList(ExchangeStudent student) async {
    var x = await _repository.fetchStories(student);
    //print('get header ${x.toString()}');
    _storyController.sink.add(x);
    //print('studentcontroller.sink.add');
  }

  disposeStudent() {
    _studentController.close();
  }

  disposeStory() {
    _storyController.close();
  }
}

// final newsBloc = NewsBloc();
//
// class HeaderBloc {
//   final _repository = Repository();
//   final _headerFetcher = PublishSubject<String>();
//   Stream<String> get allHeader => _headerFetcher.stream;
//   fetchAllHeader() async {
//     String news = await _repository.fetchHeader();
//     _headerFetcher.sink.add(news);
//   }
//
//   dispose() {
//     _headerFetcher.close();
//   }
// }
//
// final headerBloc = HeaderBloc();
