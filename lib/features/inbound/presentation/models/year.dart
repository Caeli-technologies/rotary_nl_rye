import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/features/stories/presentation/models/image_list_tile_item.dart';

class YearList extends ImageListTileItem {
  final String year;
  final String title;
  final IconData icon;
  final list;
  YearList({
    required this.year,
    required this.title,
    this.list,
    required this.icon,
  });
}
