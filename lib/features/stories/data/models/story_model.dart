import 'package:rotary_nl_rye/features/stories/domain/entities/story.dart';

class StoryModel extends Story {
  StoryModel(
      {required String country,
      required int arrivalDate,
      required int departureDate,
      required String imagePath,
      required String studentName,
      required String text1,
      required String text2})
      : super(
            country: country,
            arrivalDate: arrivalDate,
            departureDate: departureDate,
            imagePath: imagePath,
            studentName: studentName,
            text1: text1,
            text2: text2);

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
        country: json['country'],
        arrivalDate: (json['arrivalDate'] as num).toInt(),
        departureDate: (json['departureDate'] as num).toInt(),
        imagePath: json['images'],
        studentName: json['name'],
        text1: json['text1'],
        text2: json['text2']);
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'arrivalDate': arrivalDate,
      'departureDate': departureDate,
      'images': imagePath,
      'name': studentName,
      'text1': text1,
      'text2': text2
    };
  }
}
