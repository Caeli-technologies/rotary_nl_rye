class ExchangeStudent {
  final String name;
  final String description;
  final String bio;
  final String imageUrl;
  final String? video;
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

  factory ExchangeStudent.fromJson(Map<String, dynamic> json) {
    return ExchangeStudent(
      name: json['name'] as String,
      description: json['description'] as String,
      bio: json['bio'] as String,
      imageUrl: json['imageUrl'] as String,
      video: json['videoUrl'] as String?,
      from: json['from'] as String,
      fromFlag: json['fromFlag'] as String,
      to: json['to'] as String,
      toFlag: json['toFlag'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'bio': bio,
      'imageUrl': imageUrl,
      'videoUrl': video,
      'from': from,
      'fromFlag': fromFlag,
      'to': to,
      'toFlag': toFlag,
    };
  }
}
