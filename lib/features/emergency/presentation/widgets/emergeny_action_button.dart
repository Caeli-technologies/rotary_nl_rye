// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletons/skeletons.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/features/emergency/presentation/widgets/emergency_card_item.dart';
import 'package:rotary_nl_rye/features/settings/presentation/widgets/settings_option.dart';
import '../../../../core/lang/languages.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../core/prop.dart';

class EmergencyActionButton extends StatelessWidget {
  final String text, uriString;
  final IconData icon;

  const EmergencyActionButton(
    this.text,
    this.uriString, this.icon,
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final uri = Uri.parse(uriString);
        Utils.callUri(uri);
      },
      icon: Icon(
        icon,
        size: 24.0,
      ),
      label: Text(text),
    );
  }
}
