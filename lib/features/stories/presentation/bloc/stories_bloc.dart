// @dart=2.9
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary_nl_rye/core/error/failures.dart';
import 'package:rotary_nl_rye/core/usecases/usecase.dart';
import 'package:rotary_nl_rye/features/stories/domain/entities/story.dart';
import 'package:rotary_nl_rye/features/stories/domain/usecases/get_stories.dart';

part 'stories_event.dart';
part 'stories_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  StoriesBloc({this.getStories}) : super(Empty());

  final GetStories getStories;

  @override
  Stream<StoriesState> mapEventToState(
    StoriesEvent event,
  ) async* {
    if (event is BGetStories) {
      if(state is! Loaded) {
        yield Loading();
      }
      final failureOrStories = await getStories(NoParams());

      yield failureOrStories.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (stories) => Loaded(stories: stories));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
