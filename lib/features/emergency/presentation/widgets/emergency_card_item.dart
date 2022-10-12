// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyCardItem extends StatefulWidget {
  final String title, function, mobileNumber;
  final String? email;
  final IconData icon;
  final int index;

  EmergencyCardItem(
      {required this.title,
      required this.icon,
      required this.function,
      required this.mobileNumber,
      this.email,
      required this.index});

  @override
  _EmergencyCardItemState createState() => _EmergencyCardItemState(
      function: function,
      mobileNumber: mobileNumber,
      email: email,
      title: title,
      icon: icon,
      index: index);
}

class _EmergencyCardItemState extends State<EmergencyCardItem> {
  bool isExpanded = false;

  final String title, function, mobileNumber;
  final String? email;
  final IconData icon;
  final int index;

  _EmergencyCardItemState(
      {required this.title,
      required this.icon,
      required this.function,
      required this.mobileNumber,
      this.email,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15,
        bottom: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: Device.width - 220,
                    child: Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          inherit: true,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: Device.width - 220,
                    child: Text(function,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          inherit: true,
                          fontSize: 14.0,
                          color: Colors.grey,
                        )),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ElevatedButton.icon(
                  onPressed: () async {
                    final tel = Uri.parse(
                        'tel:+31${mobileNumber.toString().replaceAll(' ', '')}');
                    if (!await launchUrl(tel)) {
                      throw 'Could not launch $tel';
                    }
                  },
                  icon: Icon(
                    icon,
                    size: 24.0,
                  ),
                  label: Text(mobileNumber)),
              index == 0
                  ? SizedBox.shrink()
                  : ElevatedButton.icon(
                      onPressed: () async {
                        final mail = Uri.parse('mailto:${email}');
                        if (!await launchUrl(mail)) {
                          throw 'Could not launch $mail';
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.envelope,
                        size: 24.0,
                      ),
                      label: Text('E-Mail')),
            ],
          )
        ],
      ),
    );
  }
}
