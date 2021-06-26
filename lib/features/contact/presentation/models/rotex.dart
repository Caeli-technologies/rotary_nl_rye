import 'package:rotary_nl_rye/core/presentation/models/image_list_tile_item.dart';

class Rotex extends ImageListTileItem {
  final String name;
  final String role;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? linkedinUrl;
  final String? websiteUrl;
  final String bio;
  final String imageUrl;
  final String? email;
  final String? phoneNumber;
  Rotex(
      {required this.name,
      required this.role,
      this.facebookUrl,
      this.instagramUrl,
      this.websiteUrl,
      this.linkedinUrl,
      required this.bio,
      required this.imageUrl,
      this.email,
      this.phoneNumber});
}
