// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/models/image_list_tile_item.dart';

class DistrictList extends ImageListTileItem {
  final int number;
  final String districtName;
  final IconData icon;

  DistrictList({
    required this.number,
    required this.districtName,
    required this.icon,
  });
}
