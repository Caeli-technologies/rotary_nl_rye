// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/full_screen_image.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class RotexDetails extends StatelessWidget {
  final dynamic person;
  RotexDetails({required this.person});

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
          'Rotex',
          textScaler: TextScaler.linear(1.4),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                  FullScreenImage(url: person.imageUrl),
                            ));
                          },
                          child: CachedNetworkImage(
                            height: 60,
                            width: 60,
                            imageUrl: person.imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
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
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Text(
                                person.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  inherit: true,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Text(
                                person.role,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  inherit: true,
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset('assets/icons/custom/rotex_logo_light.svg',
                        height: 30),
                  ],
                ),
              ),
              _buildDivider(),
              _buildSocialLinks(),
              _buildDivider(),
              _buildSectionTitle('About me'),
              _buildDivider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Text(
                  DemoLocalizations.of(context)!.trans(person.bio),
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              _buildContactButtons(),
              SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return person.websiteUrl == null &&
            person.facebookUrl == null &&
            person.instagramUrl == null &&
            person.snapchatUrl == null &&
            person.phoneNumber == null
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 15, thickness: 2),
          );
  }

  Widget _buildSocialLinks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (person.instagramUrl != null)
            _buildSocialIconButton(FontAwesomeIcons.instagram,
                person.instagramUrl, Color(0xFFbc2a8d)),
          if (person.snapchatUrl != null)
            _buildSocialIconButton(FontAwesomeIcons.snapchat,
                person.snapchatUrl, Color.fromARGB(221, 201, 198, 8)),
          if (person.linkedinUrl != null)
            _buildSocialIconButton(FontAwesomeIcons.linkedinIn,
                person.linkedinUrl, Color(0xFF0e76a8)),
          if (person.facebookUrl != null)
            _buildSocialIconButton(FontAwesomeIcons.facebookF,
                person.facebookUrl, Color(0xFF3b5998)),
          if (person.websiteUrl != null)
            _buildSocialIconButton(
                FontAwesomeIcons.globe, person.websiteUrl, Color(0xFF0e76a8)),
        ],
      ),
    );
  }

  Widget _buildSocialIconButton(IconData icon, String url, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () => launchUrlString(url),
        child: FaIcon(icon, color: color),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 20),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContactButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 30, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (person.email != null)
            _buildContactButton(FontAwesomeIcons.envelope,
                'mailto:${person.email}', Colors.black),
          if (person.phoneNumber != null)
            _buildContactButton(FontAwesomeIcons.whatsapp,
                'tel:${person.phoneNumber}', Color(0xFF25D366)),
        ],
      ),
    );
  }

  Widget _buildContactButton(IconData icon, String url, Color color) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[200],
      ),
      child: RawMaterialButton(
        onPressed: () => launchUrlString(url),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: FaIcon(icon, color: color, size: 30),
      ),
    );
  }
}
