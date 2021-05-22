import 'package:rotary_nl_rye/features/stories/presentation/models/image_list_tile_item.dart';

class Organization extends ImageListTileItem {
  @override
  final String name;
  final String rotarian;
  final String role;
  final String bio;
  final String district;

  @override
  final String imageUrl;
  final String email1;
  final String email2;
  final String phoneNumber1;
  final String phoneNumber2;
  final String club;
  final Map<String, dynamic> exchangeInfo;
  Organization(
      {required this.name,
      required this.rotarian,
      required this.role,
      required this.bio,
      required this.district,
      required this.imageUrl,
      required this.email1,
      required this.email2,
      required this.phoneNumber1,
      required this.phoneNumber2,
      required this.club,
      required this.exchangeInfo});
}
