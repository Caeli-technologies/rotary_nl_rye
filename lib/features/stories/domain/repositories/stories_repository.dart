// @dart=2.9
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/story.dart';

abstract class StoriesRepository {
  Future<Either<Failure, List<Story>>> getStories();
}