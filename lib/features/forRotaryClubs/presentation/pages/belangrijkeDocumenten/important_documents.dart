// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/pdf_viewer_share.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/info_list_tile.dart';

class ImportantDocumentsPage extends StatefulWidget {
  @override
  _ImportantDocumentsPageState createState() => _ImportantDocumentsPageState();
}

class _ImportantDocumentsPageState extends State<ImportantDocumentsPage> {
  final List<Map<String, dynamic>> infoOptions = [
    {
      'title': 'Code of Policies \'Regels en Interventies\'',
      'icon': FontAwesomeIcons.peopleRoof,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/jaaruitwisseling-regels-en-interventies-v7-1-2020.pdf'),
    },
    {
      'title': "MDJC gedragscode - VJV - \n'Vrijwilliger Jeugd Verklaring'",
      'icon': FontAwesomeIcons.peopleGroup,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2023/gedragscode-vrijwilligers-mdjc-2.pdf'),
    },
    {
      'title': 'First Night Questions',
      'icon': FontAwesomeIcons.question,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/questions-first-night-host-family.pdf'),
    },
  ];

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
          'voor Rotary Clubs',
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: infoOptions.length,
        itemBuilder: (BuildContext context, int index) {
          final option = infoOptions[index];
          return InfoListTile(
            title: option['title'],
            icon: option['icon'],
            page: option['page'],
          );
        },
      ),
    );
  }
}
