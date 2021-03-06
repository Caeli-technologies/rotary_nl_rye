class News {
  final int id;
  final String images;
  final String title;
  final String? pdf;
  final String description;
  final bool isPdf;
  final List? text;

  News(
      {required this.id,
      required this.images,
      required this.description,
      required this.isPdf,
      required this.title,
      this.pdf,
      this.text});

  factory News.fromJson(Map<String, dynamic> json) => News(
      id: json['id'],
      images: json['images'],
      title: json['title'],
      description: json['description'],
      isPdf: (json['isPdf'] == 'yes') ? true : false,
      pdf: json['pdf'],
      text: json['text']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'images': images,
      'title': title,
      'description': description,
      'isPdf': isPdf ? 'yes' : 'no',
      'pdf': pdf,
      'text': text
    };
  }
}
