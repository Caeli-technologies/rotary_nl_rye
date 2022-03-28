// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/models/image_list_tile_item.dart';

class Contributor extends ImageListTileItem {
  final String name;
  final String description;
  final String bio;
  final String? githubUrl;
  final String? instagramUrl;
  final String? linkedinUrl;
  final String? websiteUrl;
  final String place;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  Contributor(
      {required this.name,
      required this.description,
      required this.bio,
      this.githubUrl,
      this.instagramUrl,
      this.websiteUrl,
      this.linkedinUrl,
      required this.place,
      required this.imageUrl,
      required this.email,
      required this.phoneNumber});
}
