import 'package:rotary_nl_rye/core/presentation/models/image_list_tile_item.dart';

class Organization extends ImageListTileItem {
  final String name;
  final String bio;
  final String district;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  final String club;
  final List<String> functions;

  Organization(
      {required this.name,
      required this.bio,
      required this.district,
      required this.imageUrl,
      required this.email,
      required this.phoneNumber,
      required this.club,
      required this.functions});
}
