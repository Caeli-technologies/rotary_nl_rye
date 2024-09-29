// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/models/image_list_tile_item.dart';

class Country extends ImageListTileItem {
  final String name;
  final String imageUrl;
  final String description;

  Country(
      {required this.name, required this.imageUrl, required this.description});
}
