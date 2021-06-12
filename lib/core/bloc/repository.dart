import 'package:rotary_nl_rye/core/bloc/api.dart';
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
        apiProvider.addBoolToSF(key: 'firstRun', value: false);
        break;
    }
  }

  Future<List<News>> fetchNews() async {
    FireStoreUrl url;
    var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
    // print("x ${x.toString()}");
    url = FireStoreUrl.fromJson(x);
    List<News> y = await apiProvider.getDataNews(url.jsonUrl!);
    return y;
  }

  Future<String> fetchHeader() async {
    FireStoreUrl url;
    var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
    url = FireStoreUrl.fromJson(x);
    return url.headerUrl!;
  }

  Future<List<ExchangeStudent>> fetchStudentList() async {
    FireStoreUrl url;
    var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
    url = FireStoreUrl.fromJson(x);
    List<ExchangeStudent> y =
        await apiProvider.getDataStudentList(url.students!);
    return y;
  }

  Future<List<Story>> fetchStories(ExchangeStudent student) async {
    FireStoreUrl url;
    //var x = await apiProvider.readFile(fileName: fireStoreUrlFile);
    //url = FireStoreUrl.fromJson(x);
    List<Story> y = await apiProvider.getDataStories(student);
    return y;
  }
}
