import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/data/database_helper.dart';

class Device {
  Device._();
  static final Device instance = Device._();

  static double width = 0;
  static double height = 0;
  static bool isDark = false;

  static String convert(int millisecondsSinceEpoch) {
    String result = "";

    List months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "September",
      "October",
      "November",
      "December"
    ];

    result += DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)
        .day
        .toString();
    result += " ";
    result += months[
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch).month - 1];
    result += " ";
    result += DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)
        .year
        .toString();

    return result;
  }

  static Future<List> readDB() async {
    print("Started reading from DB");

    // table names
    final _storiesTableName = "stories";
    final _updateTableName = "update";

    final firebaseDbRef = FirebaseDatabase.instance.reference();
    final localDbInstance = DatabaseHelper.instance;

    // fetch content from the local DB / firebase
    final fbTable = firebaseDbRef.child(_storiesTableName).once();
    bool dbHasData = await localDbInstance.hasItems(_updateTableName);

    // times
    int lastUpdate = 0;
    if (!dbHasData) {
      await localDbInstance
          .insert(_updateTableName, {DatabaseHelper.updateLast: 1});
    }

    final updateTableData = await localDbInstance.queryAll(_updateTableName);
    lastUpdate = updateTableData[0][DatabaseHelper.updateLast];

    int timeNow = DateTime.now().millisecondsSinceEpoch;
    int oneDay = 86400000;

    Future<void> clearStories() async {
      print("Started clearing $_storiesTableName table");
      await localDbInstance.reCreateStoriesTable();
      print("Finished clearing $_storiesTableName table");
    }

    Future<bool> fetchDataFromFirebase() async {
      print("Started fetching data from firebase $_storiesTableName table");
      bool temp = false;

      fbTable.asStream().forEach((element) {
        List tempList = element.value as List;
        tempList.forEach((listItem) async {
          await localDbInstance.insert(
              _storiesTableName, Map<String, dynamic>.from(listItem));
        });
        temp = (element.key == _storiesTableName);
      });
      print("Finished fetching data from firebase $_storiesTableName table");
      return temp;
    }

    Future<void> setLastUpdateTime() async {
      print("Started updating lastUpdatedTime");

      int firstId = 1;
      await localDbInstance.update(
          _updateTableName, firstId, {DatabaseHelper.updateLast: timeNow});
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
      await fetchDataFromFirebase();
      await setLastUpdateTime();
      queryRows = await fetchLocalData();
    }

    print("Finished reading from DB");
    return queryRows;
  }
}

class Palette {
  Palette._();
  static final Palette _instance = Palette._();

  static Color indigo = 0 as Color;
  static Color themeShadeColor = 0 as Color;
  static Color accentColor = 0 as Color;
  static Color grey = 0 as Color;
  static Color lightIndigo = 0 as Color;

  static Palette get instance {
    _instance.set();
    return _instance;
  }

  set() {
    accentColor = Color.fromRGBO(57, 182, 245, 1);
    grey = Colors.grey[600]!;
    lightIndigo = Colors.indigo[100]!;

    if (Device.isDark) {
      indigo = Colors.indigo[400]!;
      themeShadeColor = Colors.grey[800]!;
    } else {
      indigo = Colors.indigo[800]!;
      themeShadeColor = Colors.grey[100]!;
    }
  }
}
