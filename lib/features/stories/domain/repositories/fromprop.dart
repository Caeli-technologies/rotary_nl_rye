// @dart = 2.9
import '../../data/datasources/firebase.dart';
import '../../data/datasources/local.dart';

class Data {
  static Future<List> readDB() async {
    print("Started reading from DB");

    // table names
    final _storiesTableName = "stories";
    final _updateTableName = "update";

    final localDbInstance = LocalDB.instance;

    bool updateTableHasData = await localDbInstance.hasItems(_updateTableName);

    if (!updateTableHasData) {
      await localDbInstance.insert(_updateTableName, {LocalDB.updateLast: 1});
    }

    int lastUpdate = 0;

    final updateTableData = await localDbInstance.queryAll(_updateTableName);
    lastUpdate = updateTableData[0][LocalDB.updateLast];

    int timeNow = DateTime.now().millisecondsSinceEpoch;
    int oneDay = 86400000;

    List queryRows = await localDbInstance.queryAll(_storiesTableName);

    /// overwrite queryRows, if since the lastUpdate 24h passed and internet access is available
    if ((timeNow - lastUpdate) > oneDay) {
      queryRows = await FirebaseDB.getTable(_storiesTableName);
      /// check if data was fetched
      if (queryRows.toString() != "[]") {
        /// clears stories table
        await localDbInstance.reCreateStoriesTable();
        // TODO Insert data into local db
        /// sets last update time
        int firstId = 1;
        await localDbInstance.update(_updateTableName, firstId, {LocalDB.updateLast: timeNow});
      }
    }

    print("Finished reading from DB");
    return queryRows;
  }
}
