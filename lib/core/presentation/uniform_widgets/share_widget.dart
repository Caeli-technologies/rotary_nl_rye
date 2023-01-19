// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:share_plus/share_plus.dart';

// 🌎 Project imports:
import '../../prop.dart';

class ShareWidget extends StatelessWidget {
  final String text;
  final String? subject;

  const ShareWidget({
    Key? key,
    required this.text,
    this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.share,
        color: Palette.indigo,
      ),
      onPressed: () {
        Share.share(
            text,
            subject: subject);
      },
    );
  }
}
