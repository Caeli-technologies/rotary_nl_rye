// @dart=2.9
import 'package:firebase_database/firebase_database.dart';
import 'package:rotary_nl_rye/core/error/exceptions.dart';
import 'package:rotary_nl_rye/features/stories/data/models/story_model.dart';

import '../../domain/entities/story.dart';

abstract class StoriesRemoteDataSource {
  /// Fetches stories data from firebase.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<StoryModel>> getStories();
}

const STORIES_TABLE = "stories";

class StoriesRemoteDataSourceImpl implements StoriesRemoteDataSource {
  final FirebaseDatabase firebaseDatabase;

  StoriesRemoteDataSourceImpl({this.firebaseDatabase});

  @override
  Future<List<StoryModel>> getStories() {
    List<Map<String, dynamic>> tempList = [];
    firebaseDatabase.reference().once().asStream().forEach((element) async {
      if(element.key == STORIES_TABLE) {
        tempList = await element.value as List<Map<String, dynamic>>;
      }
    });

    if(tempList != [])
    {
      List<StoryModel> storiesList;
      tempList.forEach((element) {
        storiesList.add(StoryModel.fromJson(element));
      });
      return Future.value(storiesList);
    }

    throw ServerException();
  }
}