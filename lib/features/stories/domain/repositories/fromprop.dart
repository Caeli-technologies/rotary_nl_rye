import 'package:rotary_nl_rye/features/stories/data/datasources/firebase.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/local.dart';

class Data {
  static Future<List> readDB() async {
    print("Started reading from DB");

// table names
    final _storiesTableName = "stories";
    final _updateTableName = "update";

    final localDbInstance = LocalDB.instance;

// fetch content from the local DB / firebase
    bool dbHasData = await localDbInstance.hasItems(_updateTableName);

// times
    int lastUpdate = 0;
    if (!dbHasData) {
      await localDbInstance
          .insert(_updateTableName, {LocalDB.updateLast: 1});
    }

    final updateTableData = await localDbInstance.queryAll(_updateTableName);
    lastUpdate = updateTableData[0][LocalDB.updateLast];

    int timeNow = DateTime.now().millisecondsSinceEpoch;
    int oneDay = 86400000;

    Future<void> clearStories() async {
      print("Started clearing $_storiesTableName table");
      await localDbInstance.reCreateStoriesTable();
      print("Finished clearing $_storiesTableName table");
    }

    Future<void> setLastUpdateTime() async {
      print("Started updating lastUpdatedTime");

      int firstId = 1;
      await localDbInstance.update(
          _updateTableName, firstId, {LocalDB.updateLast: timeNow});
      print("Finished updating lastUpdatedTime");
    }

    Future<List> fetchLocalData() async {
      print("Started fetching data from local db $_storiesTableName table");
      final data = await localDbInstance.queryAll(_storiesTableName);

      print("Finished fetching data from local db $_storiesTableName table");
      return data;
    }

    List queryRows = await fetchLocalData();

    if ((timeNow - lastUpdate) > oneDay) {
      await clearStories();
      queryRows = await FirebaseDB.getTable(_storiesTableName);
      await setLastUpdateTime();
    }

    print(queryRows);
    print("Finished reading from DB");
    return queryRows;
  }
}
