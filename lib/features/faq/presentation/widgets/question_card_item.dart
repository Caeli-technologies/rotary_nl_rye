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
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      margin: EdgeInsets.only(right: 12.0, left: 12, top: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          leading: Icon(icon),
          // backgroundColor: Colors.white,
          title: _buildTitle(),
          // trailing: SizedBox(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: Device.width - 100,
                    child: Text(cardTitle,
                        softWrap: true,
                        style: TextStyle(
                          inherit: true,
                          fontSize: 20.0,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: Device.width - 100,
                    child: Text(cardText,
                        softWrap: true,
                        style: TextStyle(
                          inherit: true,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(title),
          ],
        ),
        Text(subtitle),
      ],
    );
  }
}
