// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import '../../../../core/presentation/utils.dart';

class SettingsFooterLink extends StatelessWidget {
  final String title;
  final String domain;
  final String path;

  const SettingsFooterLink({
    Key? key,
    required this.title,
    required this.path,
    this.domain = 'rotary.nl',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Utils.callUri(
                  Uri.https(domain, path),
                );
              },
          ),
        ],
      ),
    );
  }
}
