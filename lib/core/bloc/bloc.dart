import 'dart:async';

import 'package:rotary_nl_rye/core/bloc/repository.dart';
import 'package:rotary_nl_rye/features/news/models/news.dart';
import 'package:rotary_nl_rye/features/stories/models/exchange_student.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsController = StreamController<List<News>>.broadcast();

  get news => _newsController.stream;
  final _headerController = StreamController<String>.broadcast();

  get header => _headerController.stream;
  final _studentController =
      StreamController<List<ExchangeStudent>>.broadcast();

  get studentList => _studentController.stream;

  NewsBloc() {
    getNews();
  }

  getNews() async {
    _newsController.sink.add(await _repository.fetchNews());
  }

  getHeader() async {
    _headerController.sink.add(_repository.fetchHeader());
  }

  getStudentList() async {
    _headerController.sink.add(_repository.fetchStudentList());
  }

  dispose() {
    _newsController.close();
    _headerController.close();
    _studentController.close();
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
