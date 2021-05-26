import 'package:rotary_nl_rye/core/presentation/models/image_list_tile_item.dart';

class Counselors extends ImageListTileItem {
  final String name;
  final String bio;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  final String functions;
  Counselors(
      {required this.name,
      required this.bio,
      required this.imageUrl,
      required this.email,
      required this.phoneNumber,
      required this.functions});
}
