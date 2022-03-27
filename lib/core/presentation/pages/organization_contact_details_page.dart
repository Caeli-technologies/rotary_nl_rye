//TODO this is just a test. maybe we can build on this.

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/full_screen_image.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/open_whatsapp.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/organization.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizationDetails extends StatelessWidget {
  final Organization person;

  OrganizationDetails({required this.person});

  final List<Widget> fx = [];

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
          'Organization',
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
                              child: Text(person.functions[0],
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
                    SvgPicture.asset('assets/icons/custom/rotary-logo-icon.svg',
                        color: Color(0xFFf7a81b), height: 30),
                  ],
                ),
              ),

              person.phoneNumber == null
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    person.phoneNumber == null
                        ? SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.zero,
                            child: Stack(
                              children: <Widget>[
                                Platform.isIOS == true
                                    ? CupertinoButton(
                                        child: FaIcon(
                                          FontAwesomeIcons.whatsapp,
                                          color: Color(
                                            0xFF25D366,
                                          ),
                                          size: 30,
                                        ),
                                        onPressed: () => openwhatsapp(
                                            context, person.phoneNumber!),
                                        padding: EdgeInsets.zero,
                                      )
                                    : TextButton(
                                        child: FaIcon(
                                          FontAwesomeIcons.whatsapp,
                                          color: Color(0xFF25D366),
                                        ),
                                        onPressed: () => openwhatsapp(
                                            context, person.phoneNumber!),
                                      ),
                              ],
                            ),
                          ),
                    // person.phoneNumber == null
                    //     ? SizedBox.shrink()
                    //     : Padding(
                    //         padding: EdgeInsets.zero,
                    //         child: Stack(
                    //           children: <Widget>[
                    //             Platform.isIOS == true
                    //                 ? CupertinoButton(
                    //                     child: FaIcon(
                    //                       FontAwesomeIcons.instagram,
                    //                       color: Color(0xFFbc2a8d),
                    //                       size: 30,
                    //                     ),
                    //                     onPressed: () => openwhatsapp(
                    //                         context, person.phoneNumber!),
                    //                     padding: EdgeInsets.zero,
                    //                   )
                    //                 : TextButton(
                    //                     child: FaIcon(
                    //                       FontAwesomeIcons.whatsapp,
                    //                       color: Color(0xFF25D366),
                    //                     ),
                    //                     onPressed: () => openwhatsapp(
                    //                         context, person.phoneNumber!),
                    //                   ),
                    //           ],
                    //         ),
                    //       ),
                    // person.phoneNumber == null
                    //     ? SizedBox.shrink()
                    //     : Padding(
                    //         padding: EdgeInsets.zero,
                    //         child: Stack(
                    //           children: <Widget>[
                    //             Platform.isIOS == true
                    //                 ? CupertinoButton(
                    //                     child: FaIcon(
                    //                       FontAwesomeIcons.whatsapp,
                    //                       color: Color(
                    //                         0xFF25D366,
                    //                       ),
                    //                       size: 30,
                    //                     ),
                    //                     onPressed: () => openwhatsapp(
                    //                         context, person.phoneNumber!),
                    //                     padding: EdgeInsets.zero,
                    //                   )
                    //                 : TextButton(
                    //                     child: FaIcon(
                    //                       FontAwesomeIcons.whatsapp,
                    //                       color: Color(0xFF25D366),
                    //                     ),
                    //                     onPressed: () => openwhatsapp(
                    //                         context, person.phoneNumber!),
                    //                   ),
                    //           ],
                    //         ),
                    //       ),
                    // person.phoneNumber == null
                    //     ? SizedBox.shrink()
                    //     : Padding(
                    //         padding: EdgeInsets.zero,
                    //         child: Stack(
                    //           children: <Widget>[
                    //             Platform.isIOS == true
                    //                 ? CupertinoButton(
                    //                     child: FaIcon(
                    //                       FontAwesomeIcons.whatsapp,
                    //                       color: Color(
                    //                         0xFF25D366,
                    //                       ),
                    //                       size: 30,
                    //                     ),
                    //                     onPressed: () => openwhatsapp(
                    //                         context, person.phoneNumber!),
                    //                     padding: EdgeInsets.zero,
                    //                   )
                    //                 : TextButton(
                    //                     child: FaIcon(
                    //                       FontAwesomeIcons.whatsapp,
                    //                       color: Color(0xFF25D366),
                    //                     ),
                    //                     onPressed: () => openwhatsapp(
                    //                         context, person.phoneNumber!),
                    //                   ),
                    //           ],
                    //         ),
                    //       ),

                    // person.snapchatUrl == null
                    //     ? SizedBox.shrink()
                    //     : Padding(
                    //         padding:
                    //             const EdgeInsets.only(right: 10.0, left: 10.0),
                    //         child: Stack(
                    //           children: <Widget>[
                    //             TextButton(
                    //               child: FaIcon(
                    //                 FontAwesomeIcons.snapchatGhost,
                    //                 color: Color(0xFFFFFC00),
                    //               ),
                    //               onPressed: () => launch(person.snapchatUrl),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    // person.linkedinUrl == null
                    //     ? SizedBox.shrink()
                    //     : Padding(
                    //         padding:
                    //             const EdgeInsets.only(right: 10.0, left: 10.0),
                    //         child: Stack(
                    //           children: <Widget>[
                    //             TextButton(
                    //               child: FaIcon(
                    //                 FontAwesomeIcons.linkedinIn,
                    //                 color: Color(0xFF0e76a8),
                    //               ),
                    //               onPressed: () => launch(person.linkedinUrl),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    // person.facebookUrl == null
                    //     ? SizedBox.shrink()
                    //     : Padding(
                    //         padding:
                    //             const EdgeInsets.only(right: 10.0, left: 10.0),
                    //         child: Stack(
                    //           children: <Widget>[
                    //             TextButton(
                    //               child: FaIcon(
                    //                 FontAwesomeIcons.facebookF,
                    //                 color: Color(0xFF3b5998),
                    //               ),
                    //               onPressed: () => launch(person.facebookUrl),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    // person.websiteUrl == null
                    //     ? SizedBox.shrink()
                    //     : Padding(
                    //         padding:
                    //             const EdgeInsets.only(right: 10.0, left: 10.0),
                    //         child: Stack(
                    //           children: <Widget>[
                    //             TextButton(
                    //               child: FaIcon(
                    //                 FontAwesomeIcons.globe,
                    //                 color: Color(0xFF0e76a8),
                    //               ),
                    //               onPressed: () => launch(person.websiteUrl),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                  ],
                ),
              ),

              person.phoneNumber == null
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
                padding: const EdgeInsets.only(left: 30.0, top: 20.0),
                child: Text(
                  'Functions',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 30.0, bottom: 5.0, right: 300),
                child: Divider(
                  height: 15,
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 2.0, left: 30.0, bottom: 15.0, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var x in person.functions)
                      Text(
                        '- $x',
                        style: TextStyle(fontSize: 15.0),
                      )
                  ],
                ),
                //Text(
                //   'hi',
                //   style: TextStyle(fontSize: 15.0),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 15.0),
                child: Text(
                  'Rotary Club',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 30.0, bottom: 5.0, right: 250),
                child: Divider(
                  height: 15,
                  thickness: 2,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 0.0, left: 30.0, bottom: 0.0),
                child: Text(
                  'Club District: ${person.district}',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 2.0, left: 30.0, bottom: 15.0),
                child: Text(
                  'Club name: ${person.club}',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 30.0, bottom: 0.0),
                child: Text(
                  'About me',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 30.0, bottom: 0.0, right: 200),
                child: Divider(
                  height: 15,
                  thickness: 2,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0),
                child: Text(
                  person.bio,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, left: 30.0, right: 20.0),
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
                                  launch('mailto:${person.email}');
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
                                launch('tel:${person.phoneNumber}');
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
