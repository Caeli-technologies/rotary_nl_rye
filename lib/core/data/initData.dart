import 'package:rotary_nl_rye/core/data/datasources/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/core/data/datasources/http.dart';
import 'package:rotary_nl_rye/core/data/repository/exchange_students.dart';
import 'package:rotary_nl_rye/core/data/repository/header_image_repository_impl.dart';
import 'package:rotary_nl_rye/core/data/repository/news_repository_impl.dart';
import 'package:rotary_nl_rye/core/data/repository/stories_repository_impl.dart';

class Repo {
  final ApiResponse apiResponse = new ApiResponse();
  final Cache cache = new Cache();

  Future<void> initData(String studentExchangeYear, String studentName) async {
    print("initData");
    if (studentExchangeYear != "" && studentName != "") {
      await StoriesRepositoryImpl().cacheStories(
          studentExchangeYear, studentName);
    }
    if (!(await isDataPresent()) || await isTooOld()) {
      await cacheData();
    }
  }

  Future<void> cacheData() async {
    print('Caching...');
    await cache.clear();
    await HeaderImageRepositoryImpl().cacheImageHeader();
    await NewsRepositoryImpl().cacheNews();
    await ExchangeStudentsRepositoryImpl().cacheExchangeStudents();
    await cache.store(Config.spLastUpdateKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> isDataPresent() async {
    final Set<String> keys = await cache.getKeys();
    return keys.contains(Config.spLastUpdateKey);
  }

  Future<bool> isTooOld() async {
    DateTime dateTime = await getLastUpdate();
    final age = dateTime.difference(DateTime.now());
    return age > Config.maxAge;
  }

  Future<DateTime> getLastUpdate() async {
    final int lastUpdate = await cache.getByKey(Config.spLastUpdateKey) as int;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(lastUpdate);
    return dateTime;
  }
}
