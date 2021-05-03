import 'package:rotary_nl_rye/features/stories/data/models/story_model.dart';

import '../../domain/entities/story.dart';

abstract class StoriesLocalDataSource {
  /// Fetches the cached list of [StoryModel] which was gotten previously from remote-data-source
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<Story>> getStories();

  Future<void> cacheStories(List<StoryModel> storiesToCache);
}