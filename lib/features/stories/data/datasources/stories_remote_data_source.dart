import '../../domain/entities/story.dart';

abstract class StoriesRemoteDataSource {
  /// Fetches stories data from firebase.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<Story>> getStories();
}