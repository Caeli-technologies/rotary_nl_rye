// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../prop.dart';

class FooterNote extends StatelessWidget {
  final String text;

  const FooterNote({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: kNodeColor,
            ),
      ),
    );
  }
}
