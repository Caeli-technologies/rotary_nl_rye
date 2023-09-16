// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/pdf_viewer_share.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/show_alert_dialog.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class InfoGastgezinPage extends StatefulWidget {
  @override
  _InfoGastgezinPageState createState() => _InfoGastgezinPageState();
}

class _InfoGastgezinPageState extends State<InfoGastgezinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: UniformBackButton(),
        title: Text(
          'Info Gastgezin',
          textScaleFactor: 1.2,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Draaiboek Gastgezin',
                FontAwesomeIcons.peopleRoof,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2023/draaiboek-gastgezin-versie-2023.pdf',
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),

              buildInboundOptionRow(
                context,
                'First Night Questions',
                FontAwesomeIcons.question,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/questions-first-night-host-family.pdf',
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),

              buildInboundOptionRow(
                context,
                'Travel rules within and outside the Netherlands',
                FontAwesomeIcons.personWalkingLuggage,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2023/travel-rules-within-and-outside-the-netherlands-2023-2024.pdf',
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),

              // the end
              SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildInboundOptionRow(
    BuildContext context,
    String title,
    IconData icon,
    pushTo,
  ) {
    return GestureDetector(
        child: Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.zero,
          child: Container(
            child: FaIcon(
              icon,
              color: Palette.lightIndigo,
              size: 27,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Device.width - 130,
              child: Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 15,
                    color: Palette.grey,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Palette.grey,
            ),
          ],
        ),
        onTap: () {
          if (pushTo != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pushTo),
            );
          } else {
            String title = 'Comming soon';
            String message = 'This page is not yet ready';
            showMaterialDialog(
              context,
              title,
              message,
              null,
            );
          }
        },
      ),
    ));
  }
}
