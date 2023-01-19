// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletons/skeletons.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/features/settings/presentation/widgets/settings_option.dart';
import '../../../../core/lang/languages.dart';
import '../../../../core/prop.dart';

class SettingsSection extends StatelessWidget {
  final String title;

  final List<SettingsOption> options;

  const SettingsSection({
    Key? key,
    required this.title, required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Palette.themeShadeColor,
              borderRadius: BorderRadius.circular(kBorderRadius),
              boxShadow: [kSubtleBoxShadow]),
          child: Column(
            children: options,
          ),
        ),
      ],
    );
  }
}
