class NewsResult {
  NewsResult({required this.news});

  List<News> news = [];

  NewsResult.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      json['news'].forEach((v) {
        news.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
      };
}

class News {
  final String images;
  final String title;
  final String? pdf;
  final String description;
  final bool isPdf;
  final List? text;

  News(
      {required this.images,
      required this.description,
      required this.isPdf,
      required this.title,
      this.pdf,
      this.text});

  factory News.fromJson(Map<String, dynamic> json) => News(
      images: json["images"],
      title: json["title"],
      description: json["description"],
      isPdf: (json["isPdf"] == 'yes') ? true : false,
      pdf: json["pdf"],
      text: json["text"]);

  Map<String, dynamic> toJson() {
    return {
      "images": images,
      "title": title,
      "description": description,
      "isPdf": isPdf ? "yes" : "no",
      "pdf": pdf,
      "text": text
    };
  }
}
