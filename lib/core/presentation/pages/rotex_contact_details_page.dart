import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/full_screen_image.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:url_launcher/url_launcher.dart';

class RotexDetails extends StatelessWidget {
  final person;
  RotexDetails({required this.person});

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
          "Rotex",
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
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                            borderRadius: BorderRadius.circular(60),
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) =>
                                      FullScreenImage(url: person.imageUrl)));
                            },
                            child: CachedNetworkImage(
                              height: 60,
                              width: 60,
                              imageUrl: person.imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: Device.width - 150,
                              child: Text(person.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                    inherit: true,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              width: Device.width - 150,
                              child: Text(person.role,
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
                    SvgPicture.asset('assets/icons/custom/rotex_logo_light.svg',
                        // color: Color(0xFFf7a81b),
                        height: 30),
                  ],
                ),
              ),
              person.websiteUrl == null &&
                      person.facebookUrl == null &&
                      person.instagramUrl == null &&
                      person.snapchatUrl == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 20.0, bottom: 0.0, right: 20),
                      child: Divider(
                        height: 15,
                        thickness: 2,
                      ),
                    ),
              //TODO if he has one of the socials not. then it doen't need to show up!
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    person.instagramUrl == null
                        ? SizedBox.shrink()
                        : Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Stack(
                              children: <Widget>[
                                TextButton(
                                  child: FaIcon(
                                    FontAwesomeIcons.instagram,
                                    color: Color(0xFFbc2a8d),
                                  ),
                                  onPressed: () => launch(person.instagramUrl),
                                ),
                              ],
                            ),
                          ),
                    person.snapchatUrl == null
                        ? SizedBox.shrink()
                        : Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Stack(
                              children: <Widget>[
                                TextButton(
                                  child: FaIcon(
                                    FontAwesomeIcons.snapchatGhost,
                                    color: Color(0xFFFFFC00),
                                  ),
                                  onPressed: () => launch(person.snapchatUrl),
                                ),
                              ],
                            ),
                          ),
                    person.linkedinUrl == null
                        ? SizedBox.shrink()
                        : Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Stack(
                              children: <Widget>[
                                TextButton(
                                  child: FaIcon(
                                    FontAwesomeIcons.linkedinIn,
                                    color: Color(0xFF0e76a8),
                                  ),
                                  onPressed: () => launch(person.linkedinUrl),
                                ),
                              ],
                            ),
                          ),
                    person.facebookUrl == null
                        ? SizedBox.shrink()
                        : Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Stack(
                              children: <Widget>[
                                TextButton(
                                  child: FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    color: Color(0xFF3b5998),
                                  ),
                                  onPressed: () => launch(person.facebookUrl),
                                ),
                              ],
                            ),
                          ),
                    person.websiteUrl == null
                        ? SizedBox.shrink()
                        : Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Stack(
                              children: <Widget>[
                                TextButton(
                                  child: FaIcon(
                                    FontAwesomeIcons.globe,
                                    color: Color(0xFF0e76a8),
                                  ),
                                  onPressed: () => launch(person.websiteUrl),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),

              person.websiteUrl == null &&
                      person.linkedinUrl == null &&
                      person.facebookUrl == null &&
                      person.instagramUrl == null &&
                      person.snapchatUrl == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 20.0, bottom: 10.0, right: 20),
                      child: Divider(
                        height: 15,
                        thickness: 2,
                      ),
                    ),

              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 30.0, bottom: 0.0),
                child: Text(
                  "About me",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 30.0, bottom: 0.0, right: 300),
                child: Divider(
                  height: 15,
                  thickness: 2,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0),
                child: Text(
                  DemoLocalizations.of(context).trans(person.bio),
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 30.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    person.email == null
                        ? SizedBox.shrink()
                        : Container(
                            height: 70.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.grey[200],
                            ),
                            child: RawMaterialButton(
                                onPressed: () {
                                  launch("mailto:${person.email}");
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: FaIcon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.black,
                                  size: 30,
                                ))),
                    person.phoneNumber == null
                        ? SizedBox.shrink()
                        : Container(
                            height: 65.0,
                            width: 180.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.0),
                                border: Border.all(
                                    color: Colors.blue.shade100, width: 5),
                                color: Colors.blue[400]),
                            child: RawMaterialButton(
                              onPressed: () {
                                launch("tel:${person.phoneNumber}");
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.0)),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.phone,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Call me ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0),
                                    ),
                                  )
                                ],
                              ),
                            ))
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          )
        ],
      ),
    );
  }
}
