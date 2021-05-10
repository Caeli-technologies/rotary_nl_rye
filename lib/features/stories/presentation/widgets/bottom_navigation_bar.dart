import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/stories/presentation/widgets/icon_tab.dart';

import '../../../../core/prop.dart';

class BottomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.themeShadeColor,
      child: TabBar(
          tabs: [
            IconTab(iconData: FontAwesomeIcons.home),
            IconTab(iconData: FontAwesomeIcons.newspaper),
            IconTab(iconData: FontAwesomeIcons.question),
            IconTab(iconData: FontAwesomeIcons.addressCard),
            IconTab(iconData: FontAwesomeIcons.cog)
          ],
          unselectedLabelColor: Palette.lightIndigo,
          labelColor: Palette.indigo,
          indicatorColor: Colors.transparent),
    );
  }
}