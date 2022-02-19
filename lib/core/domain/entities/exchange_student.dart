class ExchangeStudent {
  final String name;
  final String description;
  final String exchangeYear;

  final String country, sponsorDistrict, hostDistrict;
  final String imageUrl;

  ExchangeStudent({
    required this.name,
    required this.description,
    required this.exchangeYear,
    required this.country,
    required this.sponsorDistrict,
    required this.hostDistrict,
    required this.imageUrl,
  });

  factory ExchangeStudent.fromJson(Map<String, dynamic> json) =>
      ExchangeStudent(
        name: json['name'],
        description: json['description'],
        exchangeYear: json['exchangeYear'],
        country: json['country'],
        sponsorDistrict: json['sponsorDistrict'],
        hostDistrict: json['hostDistrict'],
        imageUrl: json['imageUrl'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'exchangeYear': exchangeYear,
        'country': country,
        'sponsorDistrict': sponsorDistrict,
        'hostDistrict': hostDistrict,
        'imageUrl': imageUrl
      };
}
