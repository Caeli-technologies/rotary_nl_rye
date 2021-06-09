import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rotary_nl_rye/features/news/models/news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class ApiProvider {
  /// Firestore fetch
  Future<News> fetchData() async {
    try {
      final x = await FirebaseFirestore.instance
          .collection('news')
          .doc('today')
          .get()
          .then(
            (value) => News.fromSnapshot(value),
          );
      return x;
    } catch (exception) {
      print(exception);
      throw exception;
    }
  }

  /// File CRUD
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile({required fileName}) async {
    final path = await _localPath;
    return File('$path/$fileName.txt');
  }

  Future<File> writeFile({required content, required fileName}) async {
    final file = await _localFile(fileName: fileName);

    // Write the file
    return file.writeAsString(content);
  }

  Future readFile({required fileName}) async {
    try {
      final file = await _localFile(fileName: fileName);
// todo requrires changes

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  /// Shared preferences

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', "abc");
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('stringValue');
    return stringValue;
  }

  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("stringValue");
    //Remove bool
  }
}

final filesTABLE = 'files';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "fileStatus.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $filesTABLE ("
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
