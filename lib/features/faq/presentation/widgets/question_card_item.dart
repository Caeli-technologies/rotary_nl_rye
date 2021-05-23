import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class QuestionCardItem extends StatelessWidget {
  final String title, subtitle, cardTitle, cardText;
  final IconData icon;

  QuestionCardItem(
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
