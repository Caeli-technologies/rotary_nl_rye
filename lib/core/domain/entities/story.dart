

class Story {
  final bool isDutchie;
  final String image;
  final String video;
  final String country;
  final String name;
  final String departureDate;
  final String arrivalDate;
  final String description;
  //final String message;
  final List<dynamic> message;

  Story(
      {required this.isDutchie,
      required this.image,
      required this.video,
      required this.country,
      required this.name,
      required this.departureDate,
      required this.arrivalDate,
      required this.description,
      required this.message,
      //required this.body
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
      isDutchie: json["isDutchie"],
      image: json["imageUrl"],
      video: json["videoUrl"],
      country: json["country"],
      name: json["name"],
      departureDate: json["departureDate"],
      arrivalDate: json["arrivalDate"],
      description: json["description"],
      message: json["message"],
      //body: json["body"]
  );

  Map<String, dynamic> toJson() {
    return {
      "isDutchie": isDutchie,
      "imageUrl": image,
      "videoUrl": video,
      "name": name,
      "country": country,
      "departureDate": departureDate,
      "arrivalDate": arrivalDate,
      "description": description,
      "message": message,
      //"body": body
    };
  }
}
