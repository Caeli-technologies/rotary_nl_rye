// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/pdf_viewer_share.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/show_alert_dialog.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import '../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';
import 'AlgemeneInformatie/algemeneInfo.dart';
import 'Jeugdcommissaris/jeugd_commissaris.dart';
import 'belangrijkeDocumenten/important_documents.dart';

class ForRotaryClubsPage extends StatefulWidget {
  @override
  _ForRotaryClubsPageState createState() => _ForRotaryClubsPageState();
}

class _ForRotaryClubsPageState extends State<ForRotaryClubsPage> {
  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: 'voor Rotary Clubs',
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Text(
                  'Wat leuk dat jullie als Rotary club van plan zijn om een jaarstudent te sponsoren en daarmee dus ook een jaar lang een kind binnen jullie club te ontvangen en te begeleiden. Misschien zijn jullie benaderd door een scholier van buiten jullie of mogelijk vanuit de wens van één van jullie clubleden.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Algemene Informatie',
                FontAwesomeIcons.info,
                AlgemeneInfoPage(),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Info voor de Jeugdcommissaris',
                FontAwesomeIcons.solidUser,
                InfoForJeugdcommissarisPage(),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Info Gastgezin',
                FontAwesomeIcons.peopleRoof,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/draaiboek-gastgezin-22-23-def.pdf',
                ),
              ),

              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Info Counselor',
                FontAwesomeIcons.handsHoldingChild,
                PDFPageWithShare(
                  pdfUrl:
                      'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/draaiboek-counselor-versie-2022-def.pdf',
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                context,
                'Belangrijke Documenten',
                FontAwesomeIcons.triangleExclamation,
                ImportantDocumentsPage(),
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
