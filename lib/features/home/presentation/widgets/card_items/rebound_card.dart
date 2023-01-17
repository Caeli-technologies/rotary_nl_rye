import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../stories/presentation/pages/countries_page.dart';
import 'icon_with_text_card.dart';

class ReboundCard extends IconWithTextCard {
  ReboundCard()
      : super(
    title: 'Rebound',
    iconData: FontAwesomeIcons.rotateRight,
    pushTo: CountriesPage(),
  );
}