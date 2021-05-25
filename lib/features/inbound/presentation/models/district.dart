import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/features/stories/presentation/models/image_list_tile_item.dart';

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
