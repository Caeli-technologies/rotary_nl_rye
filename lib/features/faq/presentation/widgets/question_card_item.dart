import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class QuestionCardItem extends StatefulWidget {
  final String title, subtitle, cardTitle, cardText;
  final IconData icon;

  QuestionCardItem(
      {required this.title,
      required this.icon,
      required this.subtitle,
      required this.cardTitle,
      required this.cardText});

  @override
  _QuestionCardItemState createState() => _QuestionCardItemState(
      cardTitle: cardTitle,
      cardText: cardText,
      title: title,
      subtitle: subtitle,
      icon: icon);
}

class _QuestionCardItemState extends State<QuestionCardItem> {
  bool isExpanded = false;

  final String title, subtitle, cardTitle, cardText;
  final IconData icon;

  _QuestionCardItemState(
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
          leading: Icon(
            icon,
            color: isExpanded ? Palette.isExpandedYes : Palette.isExpandedNo,
          ),
          // backgroundColor: Colors.white,
          title: _buildTitle(isExpanded: isExpanded),
          trailing: Icon(
              isExpanded ? FontAwesomeIcons.minus : FontAwesomeIcons.plus,
              size: 16,
              color: isExpanded ? Palette.isExpandedNo : Palette.isExpandedYes),

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
          onExpansionChanged: (bool expanding) =>
              setState(() => this.isExpanded = expanding),
        ),
      ),
    );
  }

  Widget _buildTitle({required bool isExpanded}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(title,
                style: TextStyle(
                  color:
                      isExpanded ? Palette.isExpandedYes : Palette.isExpandedNo,
                )),
          ],
        ),
        Text(subtitle,
            style: TextStyle(
              color: isExpanded ? Palette.isExpandedYes : Palette.isExpandedNo,
            )),
      ],
    );
  }
}
