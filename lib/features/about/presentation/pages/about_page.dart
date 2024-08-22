// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final List<Map<String, dynamic>> aboutSections = [
    {
      'title': 'Nederland MDJC : Multi district Jeugd Commissie',
      'content':
          'Internationale jeugduitwisselingen met Rotary worden al 55 jaar met succes georganiseerd. Jeugduitwisselingen zit in het DNA van Rotary. De jeugd heeft de toekomst, niet alleen voor de Rotary, maar ook voor de wereld. In 2010 is Jeugdzaken met jeugduitwisseling de vijfde Avenue binnen Rotary geworden. Jaarlijks zijn er 7000 Exchanges wereldwijd.',
      'isSubTitle': false,
    },
    {
      'title': 'DOEL UITWISSELING',
      'content': 'Connecting your minds, share future beliefs',
      'isSubTitle': true,
      'subContent': [
        {
          'prefix': '‣ Missie: ',
          'body': 'wij stellen jeugd in staat om ',
          'highlight': 'persoonlijk leiderschap ',
          'suffix': 'te ontwikkelen.'
        },
        {
          'prefix': '‣ Visie: ',
          'body': 'wij geloven dat leiderschap begint met ',
          'highlight': 'leiding geven aan jezelf ',
          'suffix':
              'om uiteindelijk anderen in staat te stellen zichzelf te ontwikkelen.'
        },
        {
          'prefix': '‣ Strategie: ',
          'body':
              'wij doen dit door jonge mensen uit te dagen en te ondersteunen om zich ',
          'highlight': 'buiten hun comfortzone ',
          'suffix': 'te manifesteren.'
        },
      ]
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
        centerTitle: false,
        title: Text(
          'About Us',
          textScaler: TextScaler.linear(1.7),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: aboutSections.map((section) {
              return section['isSubTitle']
                  ? _buildSubSection(section)
                  : _buildSection(section);
            }).toList(),
          ),
          SizedBox(height: 30.0),
          Center(
            child: Image.asset(
              'assets/image/rotary_blue.png',
              height: 55.0,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Update: 10 Aug 2021',
                style: TextStyle(color: Color(0xFF777777)),
              ),
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> section) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section['title'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(
              fontSize: 20.0,
              color: Palette.titleText,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            section['content'],
            style: TextStyle(color: Palette.bodyText, fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildSubSection(Map<String, dynamic> section) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section['title'],
            style: TextStyle(
              color: Colors.blue[700],
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            section['content'],
            style: TextStyle(
              color: Colors.yellow[700],
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          ...section['subContent'].map<Widget>((sub) {
            return Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15),
                  children: [
                    TextSpan(
                      text: sub['prefix'],
                      style: TextStyle(
                        color: Palette.titleText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: sub['body']),
                    TextSpan(
                      text: sub['highlight'],
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(text: sub['suffix']),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
