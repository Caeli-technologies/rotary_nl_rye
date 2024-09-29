// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/pages/short_term/ngse/ngse_inbound_page.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/show_alert_dialog.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'long_term/long_term_inbound_page.dart';

class InboundPage extends StatefulWidget {
  @override
  _InboundPageState createState() => _InboundPageState();
}

class _InboundPageState extends State<InboundPage> {
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
          'Inbound',
          textScaler: TextScaler.linear(1.4),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
                    children: [
                      TextSpan(
                          text: 'Inbounds',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              ' Wow, we’re so excited that you will be our inbound exchange student for the coming year. For this to happen we will need some extra information so please watch your email inbox on a regular basis. Also you can find some further information in this app. If you have any questions that are not answered, please contact our inbound coordinator '),
                      TextSpan(
                        text: 'Clasine Scheepers',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              launchUrlString('mailto:longtermin@rotaryyep.nl'),
                      ),
                      TextSpan(text: ' and/or '),
                      TextSpan(
                        text: 'Ben Mureau',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrlString(
                              'mailto:longtermadmin@rotaryyep.nl'),
                      ),
                    ],
                  ),
                ),
              ),
              sectionHeader(context, 'Long Term Exchange Program'),
              buildInboundOptionRow(
                context,
                'Long Term Exchange Program',
                'Year Exchange',
                FontAwesomeIcons.hashtag,
                LongTermExchangeInboundPage(),
              ),
              sectionHeader(context, 'Short Term Exchange Program'),
              buildInboundOptionRow(
                context,
                'NGSE',
                'New Generations Service Exchange',
                FontAwesomeIcons.hashtag,
                NGSEInboundStudentsPage(),
              ),
              buildInboundOptionRow(
                context,
                'FAMILY TO FAMILY',
                'Exchange between families',
                FontAwesomeIcons.hashtag,
                null,
              ),
              buildInboundOptionRow(
                context,
                'CAMPS & TOURS',
                'Summer Camps',
                FontAwesomeIcons.hashtag,
                null,
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(height: 15, thickness: 2),
        ],
      ),
    );
  }

  Widget buildInboundOptionRow(BuildContext context, String title,
      String subtitle, IconData icon, Widget? pushTo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CachedNetworkImage(
          height: 50,
          width: 50,
          imageUrl:
              'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14.0, color: Palette.descriptionText),
          ),
        ),
        onTap: () {
          if (pushTo != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pushTo));
          } else {
            showMaterialDialog(
                context, 'Coming soon', 'This page is not yet ready', null);
          }
        },
      ),
    );
  }
}
