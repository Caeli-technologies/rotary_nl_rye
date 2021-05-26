import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/models/students.dart';
import 'package:rotary_nl_rye/core/presentation/models/image_list_tile_item.dart';

class YearList extends ImageListTileItem {
  final String year;
  final String title;
  final IconData icon;
  final List<Students> list;

  YearList({
    required this.year,
    required this.title,
    required this.list,
    required this.icon,
  });
}
