import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../outbound/presentation/pages/outbound_page.dart';
import 'icon_with_text_card.dart';

class OutboundCard extends IconWithTextCard {
  OutboundCard()
      : super(
    title: 'News',
    iconData: FontAwesomeIcons.planeDeparture,
    pushTo: OutboundPage(),
  );
}