import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

const _url = 'https://www.cylog.org/headers/';

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.only(left: 10, top: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Icon(
              Icons.arrow_back,
              color: Palette.accentColor,
              size: 30.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Palette.themeShadeColor,
            padding: const EdgeInsets.all(5.0),
          ),
        ),
        title: Text(
          "Socials",
          textScaleFactor: 1.4,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildLinkOptionRow(
                  context,
                  'test1 ',
                  'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
                  ''),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildLinkOptionRow(
                  context,
                  'test2 ',
                  'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
                  ''),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildLinkOptionRow(
                  context,
                  'test3 ',
                  'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
                  ''),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildLinkOptionRow(
      BuildContext context, String title, String imageUrl, String linkUrl) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              child: CachedNetworkImage(
                height: 55,
                width: 55,
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: Device.width - 150,
                child: Text(title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      inherit: true,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Palette.grey,
                    )),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Palette.grey,
              ),
            ],
          ),
          onTap: _launchURL,
        ),
      ),
    );
  }
}

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
