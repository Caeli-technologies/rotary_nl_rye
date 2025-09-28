// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCardItem extends StatelessWidget {
  final String title, function, mobileNumber;
  final String? email;
  final IconData icon;
  final int index;

  const EmergencyCardItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.function,
    required this.mobileNumber,
    this.email,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  function,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () async {
                  final tel =
                      Uri.parse('tel:+31${mobileNumber.replaceAll(' ', '')}');
                  if (!await launchUrl(tel)) {
                    throw 'Could not launch $tel';
                  }
                },
                icon: Icon(
                  icon,
                  size: 24.0,
                ),
                label: Text(mobileNumber),
              ),
              if (index != 0 && email != null) ...[
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () async {
                    final mail = Uri.parse('mailto:$email');
                    if (!await launchUrl(mail)) {
                      throw 'Could not launch $mail';
                    }
                  },
                  icon: const Icon(
                    FontAwesomeIcons.envelope,
                    size: 24.0,
                  ),
                  label: const Text('E-Mail'),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
