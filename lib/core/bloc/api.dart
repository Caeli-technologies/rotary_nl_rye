import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rotary_nl_rye/core/bloc/domain/db_bloc.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
import 'package:rotary_nl_rye/features/news/models/firestore_url.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/file_status_entity.dart';

final String fireStoreUrlsFileName = 'firestoreUrl';
final String newsJsonFile = 'news';
final String studentListJsonFile = 'studentList';
final String firstRunKey = 'firstRun';

class ApiProvider extends DbBloc{
  /// Firestore fetch
  Future<FireStoreUrl> fetchUrls() async {
    FirebaseAuth.instance.signInAnonymously();
    print('signed in Anonymously');
    try {
      final urls = await FirebaseFirestore.instance
          .collection('news')
          .doc('today')
          .get()
          .then(
            (value) => FireStoreUrl.fromSnapshot(value),
          );
      print('FireStoreUrl fetched and parsed');
      return urls;
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
    writeFile(content: data, fileName: newsJsonFile);

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
      //writeFile(content: "{}", fileName: student.name + student.exchangeYear);
      return stories = [];
      //throw 'stories response ${response.statusCode}';
    }
    var data = json.decode(response.body);
    writeFile(
        content: data,
        fileName: student.name.replaceAll(" ", "_").toLowerCase() +
            student.exchangeYear);
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
    writeFile(content: data, fileName: studentListJsonFile);
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

  Future<File> _createFile({required String fileName}) async {
    try {
      final path = await _localPath;
      print('got local file $path/$fileName.json');
      return File('$path/$fileName.json');
    } catch (e) {
      throw 'unable to get local file $fileName:- $e';
    }
  }

  Future<File> writeFile({required content, required String fileName}) async {/// UrlsObject, fireStoreUrls
    final file = await _createFile(fileName: fileName);
    List<FileStatus>? results = await getAllFileStatus();
    List<FileStatus> contain;
    if (results != null) {
      contain =
          results.where((element) => element.fileName == fileName).toList();
    } else {
      contain = [];
    }
    try {
      if (!contain.contains(fileName)) {
        print('file doesn\'t exist in db writing... ');
        addFileStatus(FileStatus(
            fileName: fileName, lastFetch: DateTime.now(), isLocal: true));
        print('added file to db');
      } else {
        print('db already contains $fileName deferring write');
      }
    } catch (e) {
      throw 'unable to add writefile $fileName to db - $e';
    }
    try {
      print('File $fileName written and saved');
      return file.writeAsString(json.encode(content), flush: true);
    } catch (e) {
      throw 'unable to write to file $fileName - $e';
    } // Write the file
  }

  Future readFile({required String fileName}) async {
    final file = await _createFile(fileName: fileName);
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
      final file = await _createFile(fileName: fileName);
      file.delete();
      print('File deleted $fileName');
    } catch (e) {
      throw 'unable to delete file $fileName - $e';
      // If encountering an error, return 0

    }
    try {
      updateFileStatus(FileStatus(
          fileName: fireStoreUrlsFileName,
          lastFetch: DateTime.now(),
          isLocal: false));
      print('db file updated $fileName');
    } catch (e) {
      throw 'unable to update delete file $fileName to db - $e';
    }
  }

  /// Shared preferences

  addIntToSF({required String key, required int value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setInt(key, value);
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

  Future<int?> getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    int? value;
    try {
      value = prefs.getInt(key);

      print('got string $value from SF $key');
      return value;
    } catch (e) {
      throw 'unable to read string $value to SF $key - $e';
    }
  }

  isDataPresent(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    int? value = prefs.getInt(key);
    if (value == null) {
      return true;
    }
    return false;
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