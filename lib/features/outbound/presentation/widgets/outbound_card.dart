// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import '../../../home/presentation/widgets/icon_with_text_card.dart';
import '../pages/outbound_page.dart';

class OutboundCard extends IconWithTextCard {
  OutboundCard()
      : super(
    title: 'News',
    iconData: FontAwesomeIcons.planeDeparture,
    pushTo: OutboundPage(),
  );
}
