import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/icon_tab.dart';

import '../../prop.dart';

class BottomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.themeShadeColor,
      child: TabBar(
          tabs: [
            IconTab(iconData: FontAwesomeIcons.house),
            IconTab(iconData: FontAwesomeIcons.userGroup),
            IconTab(iconData: FontAwesomeIcons.question),
            IconTab(iconData: FontAwesomeIcons.addressBook),
            IconTab(iconData: FontAwesomeIcons.gear)
          ],
          unselectedLabelColor: Palette.lightIndigo,
          labelColor: Palette.indigo,
          indicatorColor: Colors.transparent),
    );
  }
}
