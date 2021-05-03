// @dart=2.9
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rotary_nl_rye/features/stories/data/models/story_model.dart';
import 'package:rotary_nl_rye/features/stories/domain/entities/story.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tStoryModel = StoryModel(
      country: "Bali",
      arrivalDate: 1632261600000,
      departureDate: 1632261600000,
      imagePath: "assets/image/3.PNG",
      studentName: "Ruben", text1: "Hi",
      text2: "test"
  );

  test(
    'should be a subclass of Story entity',
      () async {
        // assert
        expect(tStoryModel, isA<Story>());
      }
  );

  group('Json', () {
    test(
      'should return valid model from Json', () async {
          // arrange
          final Map<String, dynamic> jsonMap = json.decode(fixture('story.json'));
          // act
          final result = StoryModel.fromJson(jsonMap);
          // assert
          expect(result, tStoryModel);
      }
    );

    test(
        'should return a Json map containing the proper data', () async {
          // act
          final result = tStoryModel.toJson();
          // assert
          final expectedMap = {
            "country": "Bali",
            "images": "assets/image/3.PNG",
            "text1": "Hi",
            "text2": "test",
            "name": "Ruben",
            "departureDate": 1632261600000,
            "arrivalDate": 1632261600000
          };
          expect(result, expectedMap);
        }
    );
  });
}