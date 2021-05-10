import 'dart:convert';

import 'package:rotary_nl_rye/core/error/exceptions.dart';
import 'package:rotary_nl_rye/features/stories/data/models/update_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UpdateLocalDataSource {
  /// Fetches the [UpdateModel]
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<bool> get timeSpanIsGreaterThen24h;

  Future<void> cacheUpdate();
}

const CACHED_UPDATE = 'CACHED_UPDATE';

class UpdateLocalDataSourceImpl implements UpdateLocalDataSource {
  final SharedPreferences sharedPreferences;

  UpdateLocalDataSourceImpl({required this.sharedPreferences});

  final timeNow = DateTime.now().millisecondsSinceEpoch;
  final oneDay = 86400000; // milliseconds of a day

  @override
  Future<bool> get timeSpanIsGreaterThen24h {
    final jsonString = sharedPreferences.getString(CACHED_UPDATE);
    if (jsonString != null) {
      final updateModel = UpdateModel.fromJson(json.decode(jsonString));
      final timeSpanIsGreaterThen24h = (timeNow - updateModel.lastUpdate) > oneDay;
      return Future.value(timeSpanIsGreaterThen24h);
    }
    return Future.value(true);
  }

  @override
  Future<void> cacheUpdate() {
    final updateToCache = UpdateModel(lastUpdate: DateTime.now().millisecondsSinceEpoch);
    return sharedPreferences.setString(CACHED_UPDATE, json.encode(updateToCache));
  }
}