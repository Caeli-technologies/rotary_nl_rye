// @dart=2.9
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/story.dart';
import '../../domain/repositories/stories_repository.dart';
import '../datasources/different.dart';
import '../datasources/stories_local_data_source.dart';
import '../datasources/update_local_data_source.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  final StoriesRemoteDataSource storiesRemoteDataSource;
  final StoriesLocalDataSource storiesLocalDataSource;
  final UpdateLocalDataSource updateLocalDataSource;
  final NetworkInfo networkInfo;

  StoriesRepositoryImpl({
    @required this.storiesRemoteDataSource,
    @required this.storiesLocalDataSource,
    @required this.updateLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Story>>> getStories() async {
    if (await networkInfo.isConnected &&
        await updateLocalDataSource.timeSpanIsGreaterThen24h) {
      try {
        debugPrint('Fetch from remote');
        var remoteStories = await storiesRemoteDataSource.getStories();
        await storiesLocalDataSource.cacheStories(remoteStories);
        await updateLocalDataSource.cacheUpdate();
        return Right(remoteStories);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

    try {
      var localStories = await storiesLocalDataSource.getStories();
      return Right(localStories);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
