import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/short_term/camps_and_tours/widgets/loadCsv.dart';
import '../../../home/presentation/widgets/icon_with_text_card.dart';

class CampsAndToursCard extends IconWithTextCard {
  CampsAndToursCard()
      : super(
    title: 'Camps & Tours List',
    iconData: FontAwesomeIcons.rotateRight,
    pushTo: LoadCsv(),
  );
}

