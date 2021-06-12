import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rotary_nl_rye/core/bloc/database/db_bloc.dart';
import 'package:rotary_nl_rye/features/news/models/firestore_url.dart';
import 'package:rotary_nl_rye/features/news/models/news.dart';
import 'package:rotary_nl_rye/features/stories/models/exchange_student.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'database/database.dart';

class ApiProvider {
  final dbBloc = DbBloc();

  /// Firestore fetch
  Future<FireStoreUrl> fetchUrls() async {
    FirebaseAuth.instance.signInAnonymously();
    try {
      final x = await FirebaseFirestore.instance
          .collection('news')
          .doc('today')
          .get()
          .then(
            (value) => FireStoreUrl.fromSnapshot(value),
          );
      return x;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /// HTTP GET

  Future<List<News>> getDataNews(String url) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      print(e);
      throw 'unable to fetch news json';
    }
    if (response.statusCode != 200) {
      throw 'news response ${response.statusCode}';
    }
    var data = json.decode(response.body);
    List<News>? news;
    try {
      news = NewsResult.fromJson(data).news;
    } catch (e) {
      print(e);
      throw e;
    }

    return news;
  }

  Future<List<Story>> getDataStories(String url) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      print(e);
      throw 'unable to fetch stories json';
    }
    if (response.statusCode != 200) {
      throw 'stories response ${response.statusCode}';
    }
    var data = json.decode(response.body);
    List<Story>? stories;
    try {
      stories = StoryResult.fromJson(data).stories;
    } catch (e) {
      print(e);
      throw e;
    }

    return stories;
  }

  Future<List<ExchangeStudent>> getDataStudentList(String url) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      print(e);
      throw 'unable to fetch StudentList json';
    }
    if (response.statusCode != 200) {
      throw 'studentList response ${response.statusCode}';
    }
    var data = json.decode(response.body);
    List<ExchangeStudent>? students;
    try {
      students = ExchangeResult.fromJson(data).students;
    } catch (e) {
      print(e);
      throw e;
    }
    return students;
  }

  /// File CRUD
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile({required String fileName}) async {
    final path = await _localPath;
    return File('$path/$fileName.txt');
  }

  Future<File> writeFile({required content, required String fileName}) async {
    final file = await _localFile(fileName: fileName);
    dbBloc.addFileStatus(FileStatus(
        fileName: fireStoreUrlFile, lastFetch: DateTime.now(), isLocal: true));
    // Write the file
    return file.writeAsString(content);
  }

  Future readFile({required String fileName}) async {
    try {
      final file = await _localFile(fileName: fileName);
// todo requrires changes

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future deleteFile({required String fileName}) async {
    try {
      final file = await _localFile(fileName: fileName);
      file.delete();
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  /// Shared preferences

  addStringToSF({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  addBoolToSF({required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(key);
    return stringValue;
  }

  getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    bool? stringValue = prefs.getBool(key);
    return stringValue;
  }

  removeValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove(key);
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
    apiProvider.addStringToSF(key: dbCreate, value: DateTime.now().toString());
  }
}

final String dbCreate = 'dbCreated';

/// DataBase purge time in hours
int dbPurge = 48;
//todo enable remote config for the value
final fireStoreUrlFile = 'firestoreUrl';
final apiProvider = ApiProvider();
