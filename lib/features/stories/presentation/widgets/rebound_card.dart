import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/countries_page.dart';
import '../../../home/presentation/widgets/icon_with_text_card.dart';

class ReboundCard extends IconWithTextCard {
  ReboundCard()
      : super(
    title: 'Rebound',
    iconData: FontAwesomeIcons.rotateRight,
    pushTo: CountriesPage(),
  );
}