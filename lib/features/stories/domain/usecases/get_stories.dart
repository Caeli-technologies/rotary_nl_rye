// @dart=2.9
import '../../../../core/error/failures.dart';
import '../entities/story.dart';

import '../repositories/stories_repository.dart';
import 'package:dartz/dartz.dart';

class GetStories {
  final StoriesRepository repository;

  GetStories(this.repository);

  Future<Either<Failure, List<Story>>> execute() async {
    return await repository.getStories();
  }
}