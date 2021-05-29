import 'package:equatable/equatable.dart';

class Story extends Equatable {
  final String country;
  final String arrivalDate;
  final String departureDate;
  final String imageUrl;
  final bool onlyVideo;
  final String? videoUrl;
  final String name;
  final String text1;
  final List message;

  Story(
      {required this.country,
      required this.arrivalDate,
      required this.departureDate,
      required this.imageUrl,
      required this.name,
      required this.onlyVideo,
      this.videoUrl,
      required this.text1,
      required this.message});

  @override
  List<Object> get props => [
        country,
        arrivalDate,
        departureDate,
        imageUrl,
        name,
        text1,
        message,
        onlyVideo,
        videoUrl!
      ];

  factory Story.fromJson(Map<String, dynamic> json) => Story(
      country: json["country"],
      arrivalDate: (json["arrivalDate"]),
      departureDate: (json["departureDate"]),
      imageUrl: json["imageUrl"],
      name: json["name"],
      text1: json["text1"],
      onlyVideo: json["onlyVideo"],
      videoUrl: json["videoUrl"],
      message: json["message"]);

  Map<String, dynamic> toJson() {
    return {
      "country": country,
      "arrivalDate": arrivalDate,
      "departureDate": departureDate,
      "imageUrl": imageUrl,
      "name": name,
      "text1": text1,
      "message": message,
      "onlyVideo": onlyVideo,
      "videoUrl": videoUrl
    };
  }
}

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
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
      };
}