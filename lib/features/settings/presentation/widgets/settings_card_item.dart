import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// still need to add here the cards from settings to make settings cleaner :)

class SettingsCardItem extends StatelessWidget {
  final String title, subtitle, cardTitle, cardText;
  final IconData icon;

  SettingsCardItem(
      {required this.title,
      required this.icon,
      required this.subtitle,
      required this.cardTitle,
      required this.cardText});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      children: <Widget>[
        Text(
          cardTitle,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(cardText),
        )
      ],
    );
  }
}
