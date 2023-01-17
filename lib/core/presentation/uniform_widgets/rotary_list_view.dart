// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class RotaryListView extends StatelessWidget {
  final List<Widget> listTiles;

  const RotaryListView({required this.listTiles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      itemCount: listTiles.length,
      itemBuilder: (context, index) => listTiles[index],
      separatorBuilder: (context, index) => SizedBox(
        height: 20,
      ),
    );
  }
}
