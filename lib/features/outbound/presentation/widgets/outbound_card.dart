import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/outbound_page.dart';
import '../../../home/presentation/widgets/icon_with_text_card.dart';

class OutboundCard extends IconWithTextCard {
  OutboundCard()
      : super(
    title: 'News',
    iconData: FontAwesomeIcons.planeDeparture,
    pushTo: OutboundPage(),
  );
}