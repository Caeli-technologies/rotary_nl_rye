// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/features/emergency/presentation/widgets/emergeny_action_button.dart';

class EmergencyMailButton extends EmergencyActionButton {
  EmergencyMailButton({required String text, required String email})
      : super(text, 'mailto:$email', FontAwesomeIcons.envelope);
}
