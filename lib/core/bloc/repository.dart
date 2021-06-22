import 'package:rotary_nl_rye/core/bloc/api.dart';
import 'package:rotary_nl_rye/core/bloc/database/database.dart';
import 'package:rotary_nl_rye/features/news/models/firestore_url.dart';
import 'package:rotary_nl_rye/features/news/models/news.dart';
import 'package:rotary_nl_rye/features/stories/models/exchange_student.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';

bool firstStart = true;

class Repository {
  firstRun() async {
    firstStart = await apiProvider.getBoolValuesSF('firstRun');
    switch (firstStart) {
      case false:
        print('non first run');
        String? y = await apiProvider.getStringValuesSF(dbCreate);
        DateTime x = DateTime.parse(y!);
        if (x.difference(DateTime.now()).inHours > dbPurge) {
          print('db Purge initiated');
          apiProvider.dbBloc.deleteAllFileStatus();
          //todo instead of table delete, do all rows delete
          await apiProvider.fetchUrls().then((value) {
            apiProvider.writeFile(
                content: value.toJson(), fileName: fireStoreUrlFile);
          });
          apiProvider.addStringToSF(
              key: dbCreate, value: DateTime.now().toString());
        }
        break;
      default:
        print('first run');
        await apiProvider.fetchUrls().then((value) {
          apiProvider.writeFile(
              content: value.toJson(), fileName: fireStoreUrlFile);
        });
        apiProvider.addStringToSF(
            key: dbCreate, value: DateTime.now().toString());
        apiProvider.addBoolToSF(key: 'firstRun', value: false);
        break;
    }
  }

  Future<List<News>> fetchNews() async {
    FireStoreUrl url;

    List<FileStatus>? results =
        await apiProvider.dbBloc.fileStatusQuery(query: newsJsonFile);
    print('results ${results.toString()}');
    if (results!.length == 0) {
      var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
      // print("x ${x.toString()}");
      url = FireStoreUrl.fromJson(x);
      List<News> y = await apiProvider.getDataNews(url.jsonUrl!);
      return y;
    } else if (results[0].isLocal) {
      if ((results[0].lastFetch!.difference(DateTime.now()).inHours) >
          dbPurge) {
        apiProvider.dbBloc.deleteFileStatusById(results[0].id!);
        var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
        // print("x ${x.toString()}");
        url = FireStoreUrl.fromJson(x);
        List<News> y = await apiProvider.getDataNews(url.jsonUrl!);
        return y;
      }
      var x = await apiProvider.readFile(fileName: newsJsonFile);
      List<News>? news;
      try {
        news = NewsResult.fromJson(x).news;
        print('news parsed ');
      } catch (e) {
        print(e);
        throw 'unable to parse news response $e';
      }
      return news;
    } else {
      var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
      // print("x ${x.toString()}");
      url = FireStoreUrl.fromJson(x);
      List<News> y = await apiProvider.getDataNews(url.jsonUrl!);
      return y;
    }
  }

  Future<String> fetchHeader() async {
    FireStoreUrl url;
    var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
    url = FireStoreUrl.fromJson(x);
    return url.headerUrl!;
  }

  Future<List<ExchangeStudent>> fetchStudentList() async {
    FireStoreUrl url;
    List<FileStatus>? results =
        await apiProvider.dbBloc.fileStatusQuery(query: studentListJsonFile);
    if (results!.length == 0) {
      var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
      // print("x ${x.toString()}");
      url = FireStoreUrl.fromJson(x);
      List<ExchangeStudent> y =
          await apiProvider.getDataStudentList(url.students!);
      return y;
    } else if (results[0].isLocal) {
      if ((results[0].lastFetch!.difference(DateTime.now()).inHours) >
          dbPurge) {
        apiProvider.dbBloc.deleteFileStatusById(results[0].id!);
        var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
        // print("x ${x.toString()}");
        url = FireStoreUrl.fromJson(x);
        List<ExchangeStudent> y =
            await apiProvider.getDataStudentList(url.students!);
        return y;
      }
      var x = await apiProvider.readFile(fileName: studentListJsonFile);
      List<ExchangeStudent>? students;
      try {
        students = ExchangeResult.fromJson(x).students;
        print('StudentList parsed');
      } catch (e) {
        print(e);
        throw 'unable to parse studentList $e';
      }
      return students;
    } else {
      var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
      // print("x ${x.toString()}");
      url = FireStoreUrl.fromJson(x);
      List<ExchangeStudent> y =
          await apiProvider.getDataStudentList(url.students!);
      return y;
    }
  }

  Future<List<Story>> fetchStories(ExchangeStudent student) async {
    List<FileStatus>? results = await apiProvider.dbBloc
        .fileStatusQuery(query: student.name + student.exchangeYear);
    if (results!.length == 0) {
      List<Story> y = await apiProvider.getDataStories(student);
      return y;
    } else if (results[0].isLocal) {
      if ((results[0].lastFetch!.difference(DateTime.now()).inHours) >
          dbPurge) {
        apiProvider.dbBloc.deleteFileStatusById(results[0].id!);
      }
      var x = await apiProvider.readFile(
          fileName: student.name + student.exchangeYear);
      List<Story>? stories;
      try {
        stories = StoryResult.fromJson(x).stories;
        print('Stories parsed');
      } catch (e) {
        print(e);
        throw 'unable to parse stories $e';
      }
      return stories;
    } else {
      List<Story> y = await apiProvider.getDataStories(student);
      return y;
    }
  }
}
