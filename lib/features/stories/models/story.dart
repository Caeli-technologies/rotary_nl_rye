import 'package:rotary_nl_rye/core/domain/entities/story.dart';

class StoryResult {
  StoryResult({required this.stories});

  List<Story> stories = [];

  StoryResult.fromJson(Map<String, dynamic> json) {
    if (json['stories'] != null) {
      json['stories'].forEach((v) {
        stories.add(Story.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'stories': List<dynamic>.from(stories.map((x) => x.toJson())),
      };
}
