// @dart=2.9
import '../../../../core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/story.dart';

import '../repositories/stories_repository.dart';
import 'package:dartz/dartz.dart';

class GetStories implements UseCase<List<Story>, NoParams> {
  final StoriesRepository repository;

  GetStories(this.repository);

  @override
  Future<Either<Failure, List<Story>>> call(NoParams params) async {
    return await repository.getStories();
  }
}
