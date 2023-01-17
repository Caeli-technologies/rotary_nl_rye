// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import '../../../home/presentation/widgets/card_item.dart';
import '../../../home/presentation/widgets/icon_with_text_card.dart';
import '../pages/program_page.dart';

class ProgramCard extends IconWithTextCard {
  ProgramCard()
      : super(
    title: 'Programs',
    iconData: FontAwesomeIcons.list,
    pushTo: ProgramPage(),
  );
}

