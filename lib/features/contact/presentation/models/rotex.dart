import 'package:rotary_nl_rye/features/stories/presentation/models/image_list_tile_item.dart';

class Rotex extends ImageListTileItem {
  final String name;
  final String rotarian;
  final String role;
  final String district;
  final String description;
  final String bio;
  final String place;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  final Map<String, dynamic> exchangeInfo;
  Rotex(
      {required this.name,
      required this.rotarian,
      required this.role,
      required this.district,
      required this.description,
      required this.bio,
      required this.place,
      required this.imageUrl,
      required this.email,
      required this.phoneNumber,
      required this.exchangeInfo});
}
