class ExchangeStudent {
  final String name;
  final String description;

  final String country, sponsorDistrict, hostDistrict;
  final String imageUrl;

  ExchangeStudent({
    required this.name,
    required this.description,
    required this.country,
    required this.sponsorDistrict,
    required this.hostDistrict,
    required this.imageUrl,
  });

  factory ExchangeStudent.fromJson(Map<String, dynamic> json) =>
      ExchangeStudent(
        name: json['name'],
        description: json['description'],
        country: json['country'],
        sponsorDistrict: json['sponsorDistrict'],
        hostDistrict: json['hostDistrict'],
        imageUrl: json['imageUrl'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "country": country,
        "sponsorDistrict": sponsorDistrict,
        "hostDistrict": hostDistrict,
        "imageUrl": imageUrl
      };
}

class ExchangeResult {
  ExchangeResult({required this.students});

  List<ExchangeStudent> students = [];

  ExchangeResult.fromJson(Map<String, dynamic> json) {
    if (json['rebounds'] != null) {
      json['rebounds'].forEach((v) {
        students.add(ExchangeStudent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        "stories": List<dynamic>.from(students.map((x) => x.toJson())),
      };
}
