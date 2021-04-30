// @dart=2.9
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:rotary_nl_rye/features/stories/domain/entities/story.dart';
import 'package:rotary_nl_rye/features/stories/domain/repositories/stories_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rotary_nl_rye/features/stories/domain/usecases/get_stories.dart';

class MockStoriesRepository extends Mock implements StoriesRepository {}

void main() {
  GetStories usecase;
  MockStoriesRepository mockStoriesRepository;

  setUp(() {
    mockStoriesRepository = MockStoriesRepository();
    usecase = GetStories(mockStoriesRepository);
  });

  final List<Story> tStories = [];

  test(
    'should get stories from the repository',
      () async {
        // arrange
        when(mockStoriesRepository.getStories()).thenAnswer((_) async => Right(tStories));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tStories));
        verify(mockStoriesRepository.getStories());
        verifyNoMoreInteractions(mockStoriesRepository);
      }
  );
}