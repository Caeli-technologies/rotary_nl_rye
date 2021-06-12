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
    print('signed in Anonymously');
    try {
      final x = await FirebaseFirestore.instance
          .collection('news')
          .doc('today')
          .get()
          .then(
            (value) => FireStoreUrl.fromSnapshot(value),
          );
      print('FireStoreUrl fetched and parsed');
      return x;
    } catch (e) {
      print(e);
      throw 'unable to fetch and parse FirestoreUrl $e';
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
      print('News fetched');
    } catch (e) {
      print(e);
      throw 'unable to fetch news json $e';
    }
    if (response.statusCode != 200) {
      throw 'news response ${response.statusCode}';
    }
    var data = json.decode(response.body);
    // print('news data ${data.toString()}');
    List<News>? news;
    try {
      news = NewsResult.fromJson(data).news;
      print('news parsed ');
    } catch (e) {
      print(e);
      throw 'unable to parse news response $e';
    }

    return news;
  }

  Future<List<Story>> getDataStories(ExchangeStudent student) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(
            "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rebounds/students/${student.exchangeYear}/${student.name.replaceAll(" ", "_").toLowerCase()}.json"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print('Stories fetched');
    } catch (e) {
      print(e);
      throw 'unable to fetch stories json $e';
    }
    List<Story>? stories;
    if (response.statusCode != 200) {
      return stories = [];
      //throw 'stories response ${response.statusCode}';
    }
    var data = json.decode(response.body);

    try {
      stories = StoryResult.fromJson(data).stories;
      print('Stories parsed');
    } catch (e) {
      print(e);
      throw 'unable to parse stories $e';
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
      print('StudentList fetched');
    } catch (e) {
      print(e);
      throw 'unable to fetch StudentList json $e';
    }
    if (response.statusCode != 200) {
      throw 'studentList response ${response.statusCode}';
    }
    var data = json.decode(response.body);
    List<ExchangeStudent>? students;
    try {
      students = ExchangeResult.fromJson(data).students;
      print('StudentList parsed');
    } catch (e) {
      print(e);
      throw 'unable to parse studentList $e';
    }
    return students;
  }

  /// File CRUD
  Future<String> get _localPath async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      print('got local directory ${directory.path}');
      return directory.path;
    } catch (e) {
      throw 'unable to get local path - $e';
    }
  }

  Future<File> _localFile({required String fileName}) async {
    try {
      final path = await _localPath;
      print('got local file $path/$fileName.json');
      return File('$path/$fileName.json');
    } catch (e) {
      throw 'unable to get local file $fileName:- $e';
    }
  }

  Future<File> writeFile({required content, required String fileName}) async {
    final file = await _localFile(fileName: fileName);
    try {
      dbBloc.addFileStatus(FileStatus(
          fileName: fireStoreUrlFile,
          lastFetch: DateTime.now(),
          isLocal: true));
      print('added file to db');
    } catch (e) {
      throw 'unable to add writefile $fileName to db - $e';
    } // Write the file
    try {
      print('File $fileName written and saved');
      return file.writeAsString(json.encode(content), flush: true);
    } catch (e) {
      throw 'unable to write to file $fileName - $e';
    }
  }

  Future readFile({required String fileName}) async {
    final file = await _localFile(fileName: fileName);
    try {
// todo requrires changes

      // Read the file
      final contents = json.decode(await file.readAsString());
      print('File read $contents');
      return contents;
    } catch (e) {
      throw 'unable to read file $fileName - $e';
      // If encountering an error, return 0

    }
  }

  Future deleteFile({required String fileName}) async {
    try {
      final file = await _localFile(fileName: fileName);
      file.delete();
      print('File deleted $fileName');
    } catch (e) {
      throw 'unable to delete file $fileName - $e';
      // If encountering an error, return 0

    }
    try {
      dbBloc.updateFileStatus(FileStatus(
          fileName: fireStoreUrlFile,
          lastFetch: DateTime.now(),
          isLocal: false));
      print('db file updated $fileName');
    } catch (e) {
      throw 'unable to update delete file $fileName to db - $e';
    }
  }

  /// Shared preferences

  addStringToSF({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString(key, value);
      print('added string $value to SF $key');
    } catch (e) {
      throw 'unable to add string $value to SF $key - $e';
    }
  }

  addBoolToSF({required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setBool(key, value);

      print('added bool $value to SF $key');
    } catch (e) {
      throw 'unable to add bool $value to SF $key - $e';
    }
  }

  Future<String?> getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? value;
    try {
      value = prefs.getString(key);

      print('got string $value from SF $key');
      return value;
    } catch (e) {
      throw 'unable to read string $value to SF $key - $e';
    }
  }

  getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    bool? value;
    try {
      value = prefs.getBool(key);
      print('got bool $value from SF $key');
      return value;
    } catch (e) {
      throw 'unable to read bool $value to SF $key - $e';
    }
  }

  removeValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    try {
      prefs.remove(key);
      //Remove bool
      print('remove string from SF $key');
    } catch (e) {
      throw 'unable to remove key from SF $key - $e';
    }
  }
}

final filesTABLE = 'files';

class DatabaseProvider {
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

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "fileStatus.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    apiProvider.addStringToSF(key: dbCreate, value: DateTime.now().toString());
    print('database created');
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

final String dbCreate = 'dbCreated';

/// DataBase purge time in hours
int dbPurge = 48;
//todo enable remote config for the value
final fireStoreUrlFile = 'firestoreUrl';
final apiProvider = ApiProvider();
