import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  late SharedPreferences _sharedPref;

  Future<dynamic> getByKey(String key) async {
    _sharedPref = await SharedPreferences.getInstance();

    return Future.value(_sharedPref.get(key));
  }

  Future<void> store(String key, dynamic value) async {
    _sharedPref = await SharedPreferences.getInstance();

    if (value is String) {
      _sharedPref.setString(key, value);
      return Future.value();
    }
    if (value is int) {
      _sharedPref.setInt(key, value);
      return Future.value();
    }
    if (value is bool) {
      _sharedPref.setBool(key, value);
      return Future.value();
    }
    if (value is double) {
      _sharedPref.setDouble(key, value);
      return Future.value();
    }
    if (value is List<String>) {
      _sharedPref.setStringList(key, value);
      return Future.value();
    }

    throw Exception('unsupported type ' + value.runtimeType.toString() + ' is not supported by SharedPreferences');
  }

  Future<Set<String>> getKeys() async {
    _sharedPref = await SharedPreferences.getInstance();

    return Future.value(_sharedPref.getKeys());
  }

  Future<void> clear() async {
    _sharedPref = await SharedPreferences.getInstance();

    return Future.value(_sharedPref.clear());
  }
}