import 'package:rotary_nl_rye/core/bloc/api.dart';
import 'package:rotary_nl_rye/core/bloc/database/file_status_entity.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
import 'package:rotary_nl_rye/features/news/models/firestore_url.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';

class Repository extends ApiProvider {
//todo enable remote config for the value
  final String fireStoreUrlsFileName = 'firestoreUrl';
  final String newsJsonFile = 'news';
  final String studentListJsonFile = 'studentList';

  Future<void> init() async {
    final String creationDateKey = 'creationDate';
    bool isFirstRun = await isDataPresent(creationDateKey);

    if (isFirstRun) {
      await setupData(creationDateKey);
    } else {
      DateTime dbCreationDate = await fetchCreationDate(creationDateKey);
      if (isTooOld(dbCreationDate)) {
        deleteData();
        await setupData(creationDateKey);
      }
    }
  }

  Future<DateTime> fetchCreationDate(String creationDateKey) async {
    final int? creationDate = await getStringValuesSF(creationDateKey);
    return DateTime.fromMillisecondsSinceEpoch(creationDate!);
  }

  void deleteData() {
    deleteAllFileStatus();
  }

  bool isTooOld(DateTime time) {
    final int hours = 48;
    return time.difference(DateTime.now()).inHours > hours;
  }

  Future<void> setupData(String key) async {
    await fetchUrls().then((fireStoreUrls) {
      writeFile(
          content: fireStoreUrls.toJson(), fileName: fireStoreUrlsFileName);
    });
    addIntToSF(key: key, value: DateTime.now().millisecondsSinceEpoch);
  }

  Future<List<News>> fetchNews() async {
    FireStoreUrl url;

    List<FileStatus>? results = await fileStatusQuery(query: newsJsonFile);
    print('results ${results.toString()}');
    if (results!.length == 0) {
      var x = await readFile(fileName: fireStoreUrlsFileName);
      // print("x ${x.toString()}");
      url = FireStoreUrl.fromJson(x);
      List<News> y = await getDataNews(url.jsonUrl!);
      return y;
    } else if (results[0].isLocal) {
      if (isTooOld(results[0].lastFetch!)) {
        deleteFileStatusById(results[0]);
        var x = await readFile(fileName: fireStoreUrlsFileName);
        // print("x ${x.toString()}");
        url = FireStoreUrl.fromJson(x);
        List<News> y = await getDataNews(url.jsonUrl!);
        return y;
      }
      var x = await readFile(fileName: newsJsonFile);
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
      var x = await readFile(fileName: fireStoreUrlsFileName);
      // print("x ${x.toString()}");
      url = FireStoreUrl.fromJson(x);
      List<News> y = await getDataNews(url.jsonUrl!);
      return y;
    }
  }

  Future<String> fetchHeader() async {
    FireStoreUrl url;
    var x = await readFile(fileName: fireStoreUrlsFileName);
    url = FireStoreUrl.fromJson(x);
    return url.headerUrl!;
  }

  Future<List<ExchangeStudent>> fetchStudentList() async {
    FireStoreUrl url;
    List<FileStatus>? fileStatuses =
        await fileStatusQuery(query: studentListJsonFile);
    if (fileStatuses!.length == 0) {
      var x = await readFile(fileName: fireStoreUrlsFileName);
      // print("x ${x.toString()}");
      url = FireStoreUrl.fromJson(x);
      List<ExchangeStudent> y = await getDataStudentList(url.students!);
      return y;
    } else if (fileStatuses[0].isLocal) {
      if (isTooOld(fileStatuses[0].lastFetch!)) {
        deleteFileStatusById(fileStatuses[0]);
        var x = await readFile(fileName: fireStoreUrlsFileName);
        // print("x ${x.toString()}");
        url = FireStoreUrl.fromJson(x);
        List<ExchangeStudent> y = await getDataStudentList(url.students!);
        return y;
      }
      var x = await readFile(fileName: studentListJsonFile);
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
      var x = await readFile(fileName: fireStoreUrlsFileName);
      // print("x ${x.toString()}");
      url = FireStoreUrl.fromJson(x);
      List<ExchangeStudent> y = await getDataStudentList(url.students!);
      return y;
    }
  }

  Future<List<Story>> fetchStories(ExchangeStudent student) async {
    List<FileStatus>? results =
        await fileStatusQuery(query: student.name + student.exchangeYear);
    if (results!.length == 0) {
      List<Story> y = await getDataStories(student);
      return y;
    } else if (results[0].isLocal) {
      if (isTooOld(results[0].lastFetch!)) {
        deleteFileStatusById(results[0]);
      }
      var x = await readFile(fileName: student.name + student.exchangeYear);
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
      List<Story> y = await getDataStories(student);
      return y;
    }
  }
}
