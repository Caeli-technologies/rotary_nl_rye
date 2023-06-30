class ExchangeStudent {
  final String name;
  final String description;
  final String bio;
  final String imageUrl;
  String? video;
  final String from;
  final String fromFlag;
  final String to;
  final String toFlag;

  ExchangeStudent({
    required this.name,
    required this.description,
    required this.bio,
    required this.imageUrl,
    this.video,
    required this.from,
    required this.fromFlag,
    required this.to,
    required this.toFlag,
  });

  factory ExchangeStudent.fromJson(Map<String, dynamic> json) =>
      ExchangeStudent(
        name: json['name'],
        description: json['description'],
        bio: json['bio'],
        imageUrl: json['imageUrl'],
        video: json['videoUrl'],
        from: json['from'],
        fromFlag: json['fromFlag'],
        to: json['to'],
        toFlag: json['toFlag'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': bio,
        'bio': bio,
        'imageUrl': imageUrl,
        'videoUrl': video,
        'from': from,
        'fromFlag': fromFlag,
        'to': to,
        'toFlag': toFlag,
      };
}
