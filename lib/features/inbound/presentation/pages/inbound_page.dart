// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          textScaleFactor: 1.4,
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 20.0, bottom: 20),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16),
                        children: [
                      TextSpan(
                        text: 'Inbounds',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            ' Wow, we’re so excited that you will be our inbound exchange student for the coming year. For this to happen we will need some extra information so please watch your email inbox on a regular basis. ',
                      ),
                      TextSpan(
                        text:
                            'Also you can find some further information in this app. If you have any questions that are not answered, please contact our inbound coordinator ',
                      ),
                      // TODO go to there contact page
                      TextSpan(
                        text: 'Clasine Scheepers',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString('mailto:longtermin@rotaryyep.nl');
                          },
                      ),
                      TextSpan(
                        text: ' and/or ',
                      ),
                      TextSpan(
                        text: 'Ben Mureau',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString(
                                'mailto:longtermadmin@rotaryyep.nl');
                          },
                      ),
                    ])),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Long Term Exchange Program',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Divider(
                  height: 15,
                  thickness: 2,
                ),
              ),

              buildInboundOptionRow(
                  context,
                  'Long Term Exchange Program',
                  'Year Exchange',
                  FontAwesomeIcons.hashtag,
                  LongTermExchangeInboundPage()),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Text(
                      'Short Term Exchange Program',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Divider(
                  height: 15,
                  thickness: 2,
                ),
              ),
              buildInboundOptionRow(
                  context,
                  'NGSE',
                  'New Generations Service Exchange',
                  FontAwesomeIcons.hashtag,
                  // NGSEInboundPage(),
                  null),
              buildInboundOptionRow(
                  context,
                  'FAMILY TO FAMILY',
                  'Exchange between families',
                  FontAwesomeIcons.hashtag,
                  // FamilyToFamilyInboundPage(),
                  null),
              buildInboundOptionRow(
                  context,
                  'CAMPS & TOURS',
                  'Summer Camps',
                  FontAwesomeIcons.hashtag,
                  // CampsAndToursInboundPage(),
                  null),

              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildInboundOptionRowWhoIsWhere(
              //     context,
              //     'Inbounds, Who is Where?',
              //     FontAwesomeIcons.streetView,
              //     WhoIsWherePage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
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

  Container buildInboundOptionRow(
    BuildContext context,
    String title,
    subtitle,
    IconData icon,
    pushTo,
  ) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
              child: CachedNetworkImage(
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
          )),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Device.width - 170,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    inherit: true, fontWeight: FontWeight.w700, fontSize: 16.0),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: Device.width - 170,
                child: Text(subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        inherit: true,
                        fontSize: 14.0,
                        color: Palette.descriptionText)),
              ),
            ],
          ),
        ),
        // trailing: Icon(
        //   Icons.arrow_forward_ios,
        //   color: Palette.grey,
        // ),
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
    );
  }

  GestureDetector buildInboundOptionRowWhoIsWhere(
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
          }
        },
      ),
    ));
  }
}
