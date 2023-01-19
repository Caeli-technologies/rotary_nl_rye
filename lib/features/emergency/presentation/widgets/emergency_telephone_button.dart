// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/features/emergency/presentation/widgets/emergeny_action_button.dart';

class EmergencyTelephoneButton extends EmergencyActionButton {
  EmergencyTelephoneButton({required String text, required String telephoneNumber})
      : super(text, 'tel:$telephoneNumber', FontAwesomeIcons.phone);
}
