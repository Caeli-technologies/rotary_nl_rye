// @dart=2.9
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/update_loca_data_source.dart';
import 'package:rotary_nl_rye/features/stories/data/models/update_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/stories_local_data_source.dart';
import '../datasources/stories_remote_data_source.dart';
import '../../domain/entities/story.dart';
import '../../domain/repositories/stories_repository.dart';

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
    if(await networkInfo.isConnected && await updateLocalDataSource.timeSpanIsGreaterThen24h) {
      try {
        final remoteStories = await storiesRemoteDataSource.getStories();
        storiesLocalDataSource.cacheStories(remoteStories);
        return Right(remoteStories);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

    try {
      final localStories = await storiesLocalDataSource.getStories();
      return Right(localStories);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> cacheUpdate() async {
    try {
      final update = new UpdateModel(lastUpdate: DateTime.now().millisecondsSinceEpoch);
      await updateLocalDataSource.cacheUpdate(update);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}