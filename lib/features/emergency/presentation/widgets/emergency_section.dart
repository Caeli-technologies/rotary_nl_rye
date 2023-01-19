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
import '../../../../core/prop.dart';

class EmergencySection extends StatelessWidget {
  final String title;

  final List<EmergencyCardItem> items;

  const EmergencySection({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: 10,
        ),
        ...items,
      ],
    );
  }
}
