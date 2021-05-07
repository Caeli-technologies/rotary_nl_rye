// @dart=2.9
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'dart:convert';
import 'package:rotary_nl_rye/core/error/exceptions.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/stories_local_data_source.dart';
import 'package:rotary_nl_rye/features/stories/data/models/story_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  StoriesLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = StoriesLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences
    );
  });

  group('getStories', () {
    final tempList = json.decode(fixture('stories_cached.json'));
    final List<StoryModel> tStoriesModels = [];
    tempList.forEach((element) {
      tStoriesModels.add(StoryModel.fromJson(element));
    });

    test(
        'should return List<Stories> from SharedPreferences when there is one in the cache', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(
          fixture('stories_cached.json'));
      // act
      final result = await dataSource.getStories();
      // assert
      verify(mockSharedPreferences.getString(CACHED_STORIES));
      expect(result, equals(tStoriesModels));
    });

    test(
        'should throw CacheException when there is not a cached value', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getStories;
      // assert
      expect(call, throwsA(isA<CacheException>()));
    });
  });

  group('cacheStories', () {
    final List<StoryModel> tStoriesModels = [];

    final temp = StoryModel(
        country: "Bali",
        arrivalDate: 1632261600000,
        departureDate: 1632261600000,
        imagePath: "assets/image/3.PNG",
        studentName: "Ruben",
        text1: "Hi",
        text2: "test"
    );

    tStoriesModels.add(temp);
    tStoriesModels.add(temp);

    test('should call SharedPreferences to cache the data', () async {
      // act
      dataSource.cacheStories(tStoriesModels);
      // assert
      final expectedJsonString = json.encode(tStoriesModels);
      verify(mockSharedPreferences.setString(
          CACHED_STORIES, expectedJsonString));
    });
  });
}