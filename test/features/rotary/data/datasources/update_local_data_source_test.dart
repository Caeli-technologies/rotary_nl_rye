// @dart=2.9
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:rotary_nl_rye/core/error/exceptions.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/stories_local_data_source.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/update_local_data_source.dart';
import 'package:rotary_nl_rye/features/stories/data/models/update_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  UpdateLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = UpdateLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences
    );
  });

  group('timeSpanIsGreaterThen24h', () {
    final oneDay = 86400000;
    final tUpdate = UpdateModel.fromJson(json.decode(fixture('update_cached.json')));
    final tBool = (DateTime.now().millisecondsSinceEpoch - tUpdate.lastUpdate) > oneDay;

    test('should return lastUpdate when there is a cached UpdateModel', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture('update_cached.json'));
      // act
      final result = await dataSource.timeSpanIsGreaterThen24h;
      // assert
      verify(mockSharedPreferences.getString(CACHED_UPDATE));
      expect(result, equals(tBool));
    });

    test('should throw CacheException when there is not a cached value', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.timeSpanIsGreaterThen24h;
      // assert
      expect(call, throwsA(isA<CacheException>()));
    });
  });

  group('cacheUpdate', () {
    final UpdateModel tUpdateModel = UpdateModel(lastUpdate: DateTime.now().millisecondsSinceEpoch);

    test('should call SharedPreferences to cache the data', () async {
      // act
      dataSource.cacheUpdate();
      // assert
      final expectedJsonString = json.encode(tUpdateModel);
      verify(mockSharedPreferences.setString(CACHED_STORIES, expectedJsonString));
    });
  });
}