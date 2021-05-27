import 'package:rotary_nl_rye/core/presentation/models/image_list_tile_item.dart';

class Students extends ImageListTileItem {
  final String name;
  final String countryFlag;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? twitterUrl;
  final String? websiteUrl;
  final String district;
  final String bio;
  final String place;
  final String imageUrl;
  final String phoneNumber;
  final Map<String, dynamic> rotaryInfo;
  Students(
      {required this.name,
      required this.countryFlag,
      required this.district,
      required this.bio,
      required this.place,
      this.facebookUrl,
      this.twitterUrl,
      this.websiteUrl,
      this.instagramUrl,
      required this.imageUrl,
      required this.phoneNumber,
      required this.rotaryInfo});
}
