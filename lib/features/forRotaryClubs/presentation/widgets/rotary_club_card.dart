import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/prop.dart';
import '../pages/rotary_club_info_page.dart';
import '../../../home/presentation/widgets/card_item.dart';

class RotaryClubCard extends CardItem {
  RotaryClubCard()
      : super(
          icon: SvgPicture.asset('assets/icons/custom/rotary-logo-icon.svg',
              color: Palette.lightIndigo,
              height: 35),
          title: Text(
            'voor Rotary Clubs',
            style: TextStyle(
              fontSize: 14,
              color: Palette.indigo,
            ),
          ),
          pushTo: ForRotaryClubsPage(),
        );
}
