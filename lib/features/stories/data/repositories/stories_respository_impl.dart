// @dart=2.9
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rotary_nl_rye/core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/network_info.dart';
import '../datasources/stories_local_data_source.dart';
import '../datasources/stories_remote_data_source.dart';
import '../../domain/entities/story.dart';
import '../../domain/repositories/stories_repository.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  final StoriesRemoteDataSource remoteDataSource;
  final StoriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  StoriesRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failure, List<Story>>> getStories() async {
    networkInfo.isConnected;
    try {
      final remoteStories = await remoteDataSource.getStories();
      localDataSource.cacheStories(remoteStories);
      return Right(remoteStories);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}