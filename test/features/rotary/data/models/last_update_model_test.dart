// @dart=2.9
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rotary_nl_rye/features/stories/data/models/update_model.dart';
import 'package:rotary_nl_rye/features/stories/data/models/story_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tLastUpdateModel = UpdateModel(
      lastUpdate: 1632261600000
  );

  group('Json', () {
    test(
        'should return valid model from Json', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('last_update.json'));
      // act
      final result = UpdateModel.fromJson(jsonMap);
      // assert
      expect(result, tLastUpdateModel);
    });

    test(
        'should return a Json map containing the proper data', () async {
      // act
      final result = tLastUpdateModel.toJson();
      // assert
      final expectedMap = {
        "lastUpdate": 1632261600000
      };
      expect(result, expectedMap);
    });
  });

  test(
      'should return a boolean if since the last update 24h', () async {
    // act
    final result = tLastUpdateModel.toJson();
    // assert
    final expectedMap = {
      "lastUpdate": 1632261600000
    };
    expect(result, expectedMap);
  });
}