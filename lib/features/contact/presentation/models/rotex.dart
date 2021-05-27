import 'package:rotary_nl_rye/core/presentation/models/image_list_tile_item.dart';

class Rotex extends ImageListTileItem {
  final String name;
  final String role;
  final String district;
  final String description;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? linkedinUrl;
  final String? websiteUrl;
  final String bio;
  final String place;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  final Map<String, dynamic> exchangeInfo;
  Rotex(
      {required this.name,
      required this.role,
      required this.district,
      required this.description,
      this.facebookUrl,
      this.instagramUrl,
      this.websiteUrl,
      this.linkedinUrl,
      required this.bio,
      required this.place,
      required this.imageUrl,
      required this.email,
      required this.phoneNumber,
      required this.exchangeInfo});
}
