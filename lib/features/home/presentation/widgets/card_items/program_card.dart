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
import 'icon_with_text_card.dart';

class ProgramCard extends IconWithTextCard {
  ProgramCard()
      : super(
    title: 'Programs',
    iconData: FontAwesomeIcons.list,
    pushTo: ProgramPage(),
  );
}

