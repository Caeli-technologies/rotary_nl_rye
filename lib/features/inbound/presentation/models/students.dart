import 'package:rotary_nl_rye/features/stories/presentation/models/image_list_tile_item.dart';

class Students extends ImageListTileItem {
  final String name;
  final String countryFlag;
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
      required this.imageUrl,
      required this.phoneNumber,
      required this.rotaryInfo});
}
