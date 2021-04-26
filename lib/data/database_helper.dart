import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final _dbName = "test_v1.0.db";
  static final _dbVersion = 1;
  static final _tableName = "stories";

  // stories columns
  static final storyId = "_id";
  static final storyName = "name";
  static final storyImage = "image";
  static final storyCountry = "country";

  static final storyArrivalDate = "arrivalDate";
  static final storyDepartureDate = "departureDate";
  static final storyText1 = "text1";
  static final storyText2 = "text2";

  // event appearance
  static final eventColor = "color";

  //making it a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database = null as Database;

  Future<Database> get database async {
    if(_database != null)
      return _database;

    _database = await _initiateDatabase();

    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(    
      $storyId INTEGER PRIMARY KEY,
      $storyName TEXT NOT NULL,
      $storyImage TEXT NOT NULL,
      $storyCountry TEXT NOT NULL,

      $storyArrivalDate INTEGER,
      $storyDepartureDate INTEGER,
      $storyText1 TEXT NOT NULL,
      $storyText2 TEXT NOT NULL);
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[storyId];
    return await db.update(_tableName, row, where: '$storyId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$storyId = ?', whereArgs:  [id]);
  }
}