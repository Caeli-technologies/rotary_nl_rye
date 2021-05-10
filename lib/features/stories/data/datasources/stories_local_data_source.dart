import 'dart:convert';

import 'package:rotary_nl_rye/core/error/exceptions.dart';
import 'package:rotary_nl_rye/features/stories/data/models/story_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StoriesLocalDataSource {
  /// Fetches the cached list of [StoryModel] which was gotten previously from remote-data-source
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<StoryModel>> getStories();

  Future<void> cacheStories(List<StoryModel> storiesToCache);
}

const CACHED_STORIES = 'CACHED_STORIES';

class StoriesLocalDataSourceImpl implements StoriesLocalDataSource {
  final SharedPreferences sharedPreferences;

  StoriesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<StoryModel>> getStories() {
    // TODO issue with null value
    final jsonString = sharedPreferences.getString(CACHED_STORIES);
    if (jsonString != null) {
      final List tempList = json.decode(jsonString);
      final List<StoryModel> tStoriesModels = [];
      tempList.forEach((element) {
        tStoriesModels.add(StoryModel.fromJson(element));
      });

      return Future.value(tStoriesModels);
    }
    throw CacheException();
  }

  @override
  Future<void> cacheStories(List<StoryModel> storiesToCache) {
    return sharedPreferences.setString(CACHED_STORIES, json.encode(storiesToCache));
  }
}