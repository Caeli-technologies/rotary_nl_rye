// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

import '../../../../programs/presentation/pages/program_page.dart';
import '../card_item.dart';

class IconWithTextCard extends CardItem {
  IconWithTextCard({required String title, required IconData iconData, required Widget pushTo})
      : super(
    title: Text(
      title,
      style: heading,
    ),
    icon: FaIcon(
      iconData,
      color: Palette.lightIndigo,
      size: 35,
    ),
    pushTo: pushTo,
  );
}
