import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDB {

  static final _dbName = "test_v1.48.db";
  static final _dbVersion = 1;
  static final _storiesTableName = "stories";
  static final _updateTableName = "update";
  static final _idName = "_id";

  // stories columns
  static final _storyId = _idName;
  static final storyName = "name";
  static final storyImage = "images";
  static final storyCountry = "country";

  static final storyArrivalDate = "arrivalDate";
  static final storyDepartureDate = "departureDate";
  static final storyText1 = "text1";
  static final storyText2 = "text2";

  // update columns
  static final _updateId = _idName;
  static final updateLast = "lastUpdate";

  //making it a singleton class
  LocalDB._privateConstructor();
  static final LocalDB instance = LocalDB._privateConstructor();

  static Database _database = null as Database;

  Future<Database> get database async {
    if(_database != null as Database)
      return _database;

    _database = await _initiateDatabase();

    return _database;
  }

  _initiateDatabase() async {
    print("Initiate local db");
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await createStoriesTable(db);
    await createUpdateTable(db);
  }

  Future createStoriesTable(Database db) async{
    print("Create table $_storiesTableName");
    await db.execute('''
      CREATE TABLE "$_storiesTableName"(    
      "$_storyId" INTEGER PRIMARY KEY,
      "$storyName" TEXT NOT NULL,
      "$storyImage" TEXT NOT NULL,
      "$storyCountry" TEXT NOT NULL,

      "$storyArrivalDate" INTEGER NOT NULL,
      "$storyDepartureDate" INTEGER NOT NULL,
      "$storyText1" TEXT NOT NULL,
      "$storyText2" TEXT NOT NULL);
    ''');
    print("Created table $_storiesTableName");
  }

  Future createUpdateTable(Database db) async{
    print("Create table $_updateTableName");
    await db.execute('''
      CREATE TABLE "$_updateTableName"(
      "$_updateId" INTEGER PRIMARY KEY,
      "$updateLast" INTEGER NOT NULL);
    ''');
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    Database db = await instance.database;
    if(await hasItems(table)) {
      return await db.query(table);
    }
    return [];
  }

  Future<int> update(String table, int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(table, row, where: '"$_idName" = ?', whereArgs: [id]);
  }

  Future<bool> hasItems(String table) async {
    Database db = await instance.database;
    final firstEntry = await db.query(table, where: '"$_idName" = ?', whereArgs:  [1]);
    return firstEntry.isNotEmpty;
  }

  Future<int> delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '"$_idName" = ?', whereArgs:  [id]);
  }

  Future reCreateStoriesTable() async {
    Database db = await instance.database;
    await db.execute('DROP TABLE "$_storiesTableName"');
    createStoriesTable(db);
  }
}