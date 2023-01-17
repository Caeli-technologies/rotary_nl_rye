// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import '../../../home/presentation/widgets/icon_with_text_card.dart';
import '../pages/short_term/camps_and_tours/widgets/loadCsv.dart';

class CampsAndToursCard extends IconWithTextCard {
  CampsAndToursCard()
      : super(
          title: 'Camps & Tours List',
          iconData: FontAwesomeIcons.rotateRight,
          pushTo: LoadCsv(),
        );
}
