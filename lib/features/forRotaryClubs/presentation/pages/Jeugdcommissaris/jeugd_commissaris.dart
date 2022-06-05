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

class InfoForJeugdcommissarisPage extends StatefulWidget {
  @override
  _InfoForJeugdcommissarisPageState createState() =>
      _InfoForJeugdcommissarisPageState();
}

class _InfoForJeugdcommissarisPageState
    extends State<InfoForJeugdcommissarisPage> {
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
          'Info Jeugdcommissaris',
          textScaleFactor: 1.0,
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
                'Handboek Jeugdcommissaris',
                FontAwesomeIcons.book,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/draaiboek-jeugdcommissaris-versie-2022-def.pdf',
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Document huisbezoek',
                FontAwesomeIcons.personWalkingLuggage,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/huisbezoek-gastgezinnen22-22-def.pdf',
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Verzamelformulier VOG gegevens',
                FontAwesomeIcons.passport,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/formulier-aanlevering-vog-aanvragen-2022-2023.pdf',
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Verklaring Jeugd Vrijwilliger (VJV)',
                FontAwesomeIcons.handsHoldingChild,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/verklaring-jeugd-vrijwilliger-met-addendum-okt22-def.pdf',
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Presentielijst DJC training',
                FontAwesomeIcons.euroSign,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/presentielijst-training-clubs-gastouders-2022-2023.pdf',
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Schooldocument',
                FontAwesomeIcons.school,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/rotary-exchange-voor-middelbare-scholen-2022-2023.pdf',
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Actielijst voorbereiding komst Jaarkind',
                FontAwesomeIcons.clipboardList,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/actielijst-rotary-clubs-2022-2023-voorbereiding-ontvangst-inbound-student-def.pdf',
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
              width: Device.width - 120,
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
