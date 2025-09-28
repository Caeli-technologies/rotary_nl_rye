// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class SettingsCardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String cardTitle;
  final String cardText;
  final IconData icon;

  const SettingsCardItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.cardTitle,
    required this.cardText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                cardTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                cardText,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
