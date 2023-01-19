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

class Note extends StatelessWidget {
  final List<String> texts;

  const Note({
    Key? key,
    required this.texts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Note:',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: kNodeColor,
          ),
        ),
        ...texts.map(
          (text) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              '- $text',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: kNodeColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
