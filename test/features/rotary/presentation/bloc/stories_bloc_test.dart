// @dart=2.9
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rotary_nl_rye/core/error/failures.dart';
import 'package:rotary_nl_rye/core/usecases/usecase.dart';
import 'package:rotary_nl_rye/features/stories/domain/entities/story.dart';
import 'package:rotary_nl_rye/features/stories/domain/usecases/get_stories.dart';
import 'package:rotary_nl_rye/features/stories/presentation/bloc/stories_bloc.dart';

class MockGetStories extends Mock implements GetStories {}

void main() {
  StoriesBloc bloc;
  MockGetStories mockGetStories;

  setUp(() {
    mockGetStories = MockGetStories();
    bloc = StoriesBloc(getStories: mockGetStories);
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetStories', () {
    final tStory = Story(
        country: "Bali",
        arrivalDate: 1632261600000,
        departureDate: 1632261600000,
        imagePath: "assets/image/3.PNG",
        studentName: "Ruben", text1: "Hi",
        text2: "test"
    );

    final List<Story> tStories = [];

    tStories.add(tStory);
    tStories.add(tStory);

    test('should get stories data from the use case', () async {
      // arrange
      when(mockGetStories(any)).thenAnswer((_) async => (Right(tStories)));
      // act
      bloc.add(BGetStories());
      await untilCalled(mockGetStories(any));
      // assert
      verify(mockGetStories(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully', () async {
      // arrange
      when(mockGetStories(any)).thenAnswer((_) async => (Right(tStories)));
      // assert later
      final expected = [
        //Empty(),
        Loading(),
        Loaded(stories: tStories)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(BGetStories());
    });

    test('should emit [Loading, Error] when data is gotten successfully', () async {
      // arrange
      when(mockGetStories(any)).thenAnswer((_) async => (Left(ServerFailure())));
      // assert later
      final expected = [
        //Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(BGetStories());
    });

  });
}
