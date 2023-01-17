// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'footer_note.dart';

class LastUpdatedAt extends StatelessWidget {
  final DateTime lastUpdated;

  const LastUpdatedAt({required this.lastUpdated});

  String dateToString(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            'assets/image/rotary_blue.png',
            height: 55.0,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        FooterNote(
          text: 'Last updated: ${dateToString(lastUpdated)}',
        ),
      ],
    );
  }
}
