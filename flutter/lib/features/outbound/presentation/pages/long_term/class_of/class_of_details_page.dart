// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/full_screen_image.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/open_whatsapp.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/models/ClassOf.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class ClassOfDetails extends StatelessWidget {
  final Outbounds person;

  ClassOfDetails({required this.person});

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
          'Outbounds',
          textScaler: TextScaler.linear(1.4),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          buildProfileHeader(context),
          if (hasSocialMediaLinks() || person.phoneNumber != null)
            buildDivider(),
          if (hasSocialMediaLinks()) buildSocialMediaLinks(),
          if (hasSocialMediaLinks()) buildDivider(),
          buildAboutSection(),
          buildContactOptions(context),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
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
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 12),
              buildPersonInfo(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPersonInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: Device.width - 150,
          child: Text(
            person.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 4),
        buildLocationInfo(),
      ],
    );
  }

  Widget buildLocationInfo() {
    return Row(
      children: [
        Text(
          person.from,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 2),
        SvgPicture.asset(
          'assets/icons/flags/${person.fromFlag}.svg',
          height: 15,
        ),
        SizedBox(width: 5),
        FaIcon(
          FontAwesomeIcons.arrowRightLong,
          color: Colors.grey,
        ),
        SizedBox(width: 5),
        Text(
          person.to,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 2),
        if (person.toFlag != null)
          SvgPicture.asset(
            'assets/icons/flags/${person.toFlag}.svg',
            height: 15,
          ),
      ],
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(
        height: 15,
        thickness: 2,
      ),
    );
  }

  Widget buildSocialMediaLinks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (person.instagramUrl != null)
            buildSocialMediaIcon(FontAwesomeIcons.instagram, Color(0xFFbc2a8d),
                person.instagramUrl),
          if (person.snapchatUrl != null)
            buildSocialMediaIcon(FontAwesomeIcons.snapchat,
                Color.fromARGB(221, 201, 198, 8), person.snapchatUrl),
          if (person.linkedinUrl != null)
            buildSocialMediaIcon(FontAwesomeIcons.linkedinIn, Color(0xFF0e76a8),
                person.linkedinUrl),
          if (person.facebookUrl != null)
            buildSocialMediaIcon(FontAwesomeIcons.facebookF, Color(0xFF3b5998),
                person.facebookUrl),
          if (person.websiteUrl != null)
            buildSocialMediaIcon(
                FontAwesomeIcons.globe, Color(0xFF0e76a8), person.websiteUrl),
        ],
      ),
    );
  }

  Widget buildSocialMediaIcon(IconData icon, Color color, String? url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextButton(
        child: FaIcon(icon, color: color),
        onPressed: () => launchUrlString('$url'),
      ),
    );
  }

  Widget buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
          ),
          child: Text(
            'About me',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(height: 15, thickness: 2, endIndent: 250),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            person.bio,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Widget buildContactOptions(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 30.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (person.email != null)
            buildContactIcon(FontAwesomeIcons.envelope, Colors.black,
                'mailto:${person.email}'),
          if (person.phoneNumber != null)
            buildContactIcon(FontAwesomeIcons.whatsapp, Color(0xFF25D366),
                () => openwhatsapp(context, person.phoneNumber!)),
        ],
      ),
    );
  }

  Widget buildContactIcon(IconData icon, Color color, dynamic onTap) {
    return Container(
      height: 70.0,
      width: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey[200],
      ),
      child: RawMaterialButton(
        onPressed: onTap is String ? () => launchUrlString(onTap) : onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: FaIcon(
          icon,
          color: color,
          size: 30,
        ),
      ),
    );
  }

  bool hasSocialMediaLinks() {
    return person.instagramUrl != null ||
        person.snapchatUrl != null ||
        person.linkedinUrl != null ||
        person.facebookUrl != null ||
        person.websiteUrl != null;
  }
}
