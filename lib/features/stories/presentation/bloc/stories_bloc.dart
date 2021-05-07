import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rotary_nl_rye/core/usecases/usecase.dart';
import 'package:rotary_nl_rye/features/stories/domain/entities/story.dart';
import 'package:rotary_nl_rye/features/stories/domain/usecases/get_stories.dart';

part 'stories_event.dart';
part 'stories_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  StoriesBloc({required this.getStories}) : super(Empty());

  final GetStories getStories;

  get initialState => Empty();

  @override
  Stream<StoriesState> mapEventToState(
    StoriesEvent event,
  ) async* {
    if (event is BGetStories) {
      yield Loading();
      final failureOrStories = await getStories(NoParams());

      yield failureOrStories.fold((failure) => Error(message: SERVER_FAILURE_MESSAGE), (stories) => Loaded(stories: stories));
    }
  }
}
