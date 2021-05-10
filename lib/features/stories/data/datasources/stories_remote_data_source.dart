// @dart=2.9
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:rotary_nl_rye/core/error/exceptions.dart';
import 'package:rotary_nl_rye/features/stories/data/models/story_model.dart';

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
  Future<List<StoryModel>> getStories() async {
    List tempList = [];
    await firebaseDatabase.reference().once().asStream().forEach((element) {
      final table = element.value as Map;
      tempList = table[STORIES_TABLE];
    });

    if(tempList.toString() != "[]")
    {
      List<StoryModel> storiesList = [];
      tempList.forEach((element) {
        var temp = element as LinkedHashMap;
        storiesList.add(StoryModel.fromJson(temp.cast()));
      });
      return Future.value(storiesList);
    }

    throw ServerException();
  }
}