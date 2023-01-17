// 📦 Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/caching/cache.dart';

/// Stores data in a key value pair. No critical or sensitive data should be stored.
class SharedPreferencesCache implements Cache {
  late SharedPreferences _sharedPref;

  @override
  Future<dynamic> getByKey(String key) async {
    _sharedPref = await SharedPreferences.getInstance();

    return _sharedPref.get(key);
  }

  @override
  Future<void> store(String key, dynamic value) async {
    _sharedPref = await SharedPreferences.getInstance();

    if (value is String) {
      _sharedPref.setString(key, value);
    } else if (value is int) {
      _sharedPref.setInt(key, value);
    } else if (value is bool) {
      _sharedPref.setBool(key, value);
    } else if (value is double) {
      _sharedPref.setDouble(key, value);
    } else if (value is List<String>) {
      _sharedPref.setStringList(key, value);
    } else {
      throw Exception('unsupported type ' +
          value.runtimeType.toString() +
          ' is not supported by SharedPreferences');
    }
  }

  @override
  Future<void> invalidate() async {
    _sharedPref = await SharedPreferences.getInstance();
    _sharedPref.clear();
  }
}
