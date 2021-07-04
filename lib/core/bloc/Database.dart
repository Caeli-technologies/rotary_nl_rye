import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  final tableName = 'files';
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      print('db fetched');
      return _database!;
    }
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = documentsDirectory.path + "fileStatus.db";
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);

    print('database created');
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $tableName ("
        "id INTEGER PRIMARY KEY, "
        "fileName TEXT, "

    /*SQLITE doesn't have boolean type
        so we store isDone as integer where 0 is false
        and 1 is true*/
        "is_Local INTEGER, "
        "lastFetch TEXT "
        ")");
  }
}