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
    print("Reading DB ...");
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

    // updates data
    fbTable.asStream().forEach((element) async {
      bool isStoriesTable = (element.key == _storiesTableName);
      if (isStoriesTable && (timeNow - lastUpdate) > oneDay) {
        // clears lastUpdateTime
        print("Clearing $_storiesTableName table");

        await localDbInstance.reCreateStoriesTable().then((value) {
          // fetches data from firebase and stores it in local db
          print("Fetching data from firebase $_storiesTableName table");

          List tempList = element.value as List;
          tempList.forEach((listItem) async {
            await localDbInstance.insert(_storiesTableName, Map<String, dynamic>.from(listItem));
          });
        });

        // set lastUpdateTime
        print("Update lastUpdatedTime to " + DateTime.now().toString());

        int firstId = 1;
        await localDbInstance.update(_updateTableName, firstId, {DatabaseHelper.updateLast: timeNow});
      }
    });

    // fetches data from local db
    print("Fetching data from local db $_storiesTableName table");

    List<Map<String, dynamic>> queryRows = await localDbInstance.queryAll(_storiesTableName);

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
