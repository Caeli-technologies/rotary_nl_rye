// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import '../../../../core/presentation/utils.dart';
import 'emergency_mail_button.dart';
import 'emergency_telephone_button.dart';
import 'emergeny_action_button.dart';

class EmergencyCardItem extends StatefulWidget {
  final String name, function, mobileNumber;
  final String? email;

  EmergencyCardItem({
    required this.name,
    required this.function,
    required this.mobileNumber,
    this.email,
  });

  @override
  _EmergencyCardItemState createState() => _EmergencyCardItemState(
        function: function,
        mobileNumber: mobileNumber,
        email: email,
        name: name,
      );
}

class _EmergencyCardItemState extends State<EmergencyCardItem> {
  final String name, function, mobileNumber;
  final String? email;

  _EmergencyCardItemState({
    required this.name,
    required this.function,
    required this.mobileNumber,
    this.email,
  });

  String formatTelephoneNumber(String telephoneNumber) {
    RegExp exp = new RegExp(r'\d{2}');
    Iterable<Match> matches = exp.allMatches(telephoneNumber);
    return matches.map((match) => match.group(0)).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    function,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Color(0xFF9A9A9A)),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EmergencyTelephoneButton(
                text: formatTelephoneNumber(mobileNumber),
                telephoneNumber: mobileNumber,
              ),
              email != null
                  ? EmergencyMailButton(
                      text: 'Write an E-Mail',
                      email: email!,
                    )
                  : SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}
