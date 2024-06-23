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
import 'package:rotary_nl_rye/features/inbound/presentation/models/ClassOf.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class ClassOfDetailsInbounds extends StatelessWidget {
  final Inbounds person;
  ClassOfDetailsInbounds({required this.person});

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
          'Inbounds',
          textScaler: TextScaler.linear(1.4),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 15),
        children: <Widget>[
          buildProfileHeader(context),
          if (hasSocialMedia(person)) buildDivider(),
          buildSocialMediaRow(),
          if (hasSocialMedia(person)) buildDivider(),
          buildSectionTitle('About me'),
          buildSectionDivider(),
          buildBio(),
          if (!hasSocialMedia(person)) SizedBox(height: 40),
          buildContactButtons(context),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              buildProfileImage(context),
              SizedBox(width: 12),
              buildProfileInfo(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProfileImage(BuildContext context) {
    return InkWell(
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
    );
  }

  Widget buildProfileInfo() {
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
        buildLocationRow(),
      ],
    );
  }

  Widget buildLocationRow() {
    return SizedBox(
      width: Device.width - 150,
      child: Row(
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
      ),
    );
  }

  bool hasSocialMedia(Inbounds person) {
    return person.websiteUrl != null ||
        person.facebookUrl != null ||
        person.instagramUrl != null ||
        person.snapchatUrl != null ||
        person.phoneNumber != null;
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 15, thickness: 2),
    );
  }

  Widget buildSocialMediaRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildSocialMediaButton(
            person.instagramUrl,
            FontAwesomeIcons.instagram,
            Color(0xFFbc2a8d),
          ),
          buildSocialMediaButton(
            person.snapchatUrl,
            FontAwesomeIcons.snapchat,
            Color.fromARGB(221, 201, 198, 8),
          ),
          buildSocialMediaButton(
            person.facebookUrl,
            FontAwesomeIcons.facebookF,
            Color(0xFF3b5998),
          ),
          buildSocialMediaButton(
            person.websiteUrl,
            FontAwesomeIcons.globe,
            Color(0xFF0e76a8),
          ),
        ],
      ),
    );
  }

  Widget buildSocialMediaButton(String? url, IconData icon, Color color) {
    if (url == null) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        child: FaIcon(icon, color: color),
        onPressed: () => launchUrlString(url),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, bottom: 0),
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

  Widget buildSectionDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 300),
      child: Divider(height: 15, thickness: 2),
    );
  }

  Widget buildBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Text(
        person.bio,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget buildContactButtons(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (person.email != null) buildEmailButton(),
          if (person.phoneNumber != null) buildWhatsAppButton(context),
        ],
      ),
    );
  }

  Widget buildEmailButton() {
    return buildContactButton(
      onPressed: () => launchUrlString('mailto:${person.email}'),
      icon: FontAwesomeIcons.envelope,
      color: Colors.black,
    );
  }

  Widget buildWhatsAppButton(context) {
    return buildContactButton(
      onPressed: () => openwhatsapp(context, person.phoneNumber!),
      icon: FontAwesomeIcons.whatsapp,
      color: Color(0xFF25D366),
      iconSize: 40,
    );
  }

  Widget buildContactButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
    double iconSize = 30,
  }) {
    return Container(
      height: 70.0,
      width: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey[200],
      ),
      child: RawMaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: FaIcon(
          icon,
          color: color,
          size: iconSize,
        ),
      ),
    );
  }
}
