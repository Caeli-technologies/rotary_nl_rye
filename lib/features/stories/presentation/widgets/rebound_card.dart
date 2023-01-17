// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import '../../../home/presentation/widgets/icon_with_text_card.dart';
import '../pages/countries_page.dart';

class ReboundCard extends IconWithTextCard {
  ReboundCard()
      : super(
    title: 'Rebound',
    iconData: FontAwesomeIcons.rotateRight,
    pushTo: CountriesPage(),
  );
}
