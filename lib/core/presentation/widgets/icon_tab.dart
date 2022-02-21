import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconTab extends StatelessWidget {
  final IconData iconData;

  const IconTab({Key? key, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 70, child: Tab(icon: FaIcon(iconData, size: 30)));
  }
}
