part of 'stories_bloc.dart';

abstract class StoriesState extends Equatable {
  const StoriesState();
}

class Empty extends StoriesState {
  @override
  List<Object> get props => [];
}

class Loading extends StoriesState {
  @override
  List<Object> get props => [];
}

class Loaded extends StoriesState {
  final List<Story> stories;

  Loaded({required this.stories});

  @override
  List<Object> get props => [stories];
}

class Error extends StoriesState {
  final String message;

  // TODO log errors

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
