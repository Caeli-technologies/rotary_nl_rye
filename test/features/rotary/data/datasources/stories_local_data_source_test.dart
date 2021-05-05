// @dart=2.9
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
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

    test('should return List<Stories> from SharedPreferences when there is one in the cache', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture('stories_cached.json'));
      // act
      final result = await dataSource.getStories();
      // assert
      verify(mockSharedPreferences.getString('CACHED_STORIES'));
      expect(result, equals(tStoriesModels));
    });
  });
}