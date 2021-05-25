import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/features/stories/presentation/models/image_list_tile_item.dart';

class DistrictList extends ImageListTileItem {
  final int number;
  final String title;
  final IconData icon;
  final list;

  DistrictList({
    required this.number,
    required this.title,
    this.list,
    required this.icon,
  });
}
