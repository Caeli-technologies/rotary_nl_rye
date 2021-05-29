class Student {
  final String name;
  final String description;
  final String bio;
  final String country, sponsorDistrict, hostDistrict;
  final String imageUrl;
  final Map<String, dynamic> exchangeInfo;

  Student(
      {required this.name,
      required this.description,
      required this.bio,
      required this.country,
      required this.sponsorDistrict,
      required this.hostDistrict,
      required this.imageUrl,
      required this.exchangeInfo});

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      name: json['name'],
      description: json['description'],
      bio: json['bio'],
      country: json['country'],
      sponsorDistrict: json['sponsorDistrict'],
      hostDistrict: json['hostDistrict'],
      imageUrl: json['imageUrl'],
      exchangeInfo: json['exchangeInfo']);

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "bio": bio,
        "country": country,
        "sponsorDistrict": sponsorDistrict,
        "hostDistrict": hostDistrict,
        "imageUrl": imageUrl,
        "exchangeInfo": exchangeInfo
      };
}
