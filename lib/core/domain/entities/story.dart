class Story {
  final bool isDutchie;
  final String image;
  final String video;
  final String title;
  final String startDate;
  final String endDate;
  final String description;
  //final String message;
  final List<dynamic> message;

  Story({
    required this.isDutchie,
    required this.image,
    required this.video,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.message,
    //required this.body
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        isDutchie: json["isDutchie"],
        image: json["imageUrl"],
        video: json["videoUrl"],
        title: json["title"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        description: json["description"],
        message: json["message"],
        //body: json["body"]
      );

  Map<String, dynamic> toJson() {
    return {
      "isDutchie": isDutchie,
      "imageUrl": image,
      "videoUrl": video,
      "title": title,
      "startDate": startDate,
      "endDate": endDate,
      "description": description,
      "message": message,
      //"body": body
    };
  }
}
