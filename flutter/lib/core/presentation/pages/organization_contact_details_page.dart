// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/full_screen_image.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/open_whatsapp.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/organization.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class OrganizationDetails extends StatelessWidget {
  final Organization person;

  OrganizationDetails({required this.person});

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
          textScaler: TextScaler.linear(1.4),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _buildHeader(context),
          _buildDivider(),
          _buildSocialIcons(context),
          _buildDivider(),
          _buildFunctions(),
          _buildRotaryClubDetails(),
          _buildAboutMe(),
          _buildContactOptions(),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 12),
              Column(
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
                        inherit: true,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: Device.width - 150,
                    child: Text(
                      person.functions.isNotEmpty ? person.functions[0] : '',
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
          SvgPicture.asset('assets/icons/custom/rotary-logo-icon.svg',
              colorFilter: ColorFilter.mode(Color(0xFFf7a81b), BlendMode.srcIn),
              height: 30),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return person.phoneNumber == null
        ? SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(height: 15, thickness: 2),
          );
  }

  Widget _buildSocialIcons(BuildContext context) {
    if (person.phoneNumber == null) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildSocialIcon(
            context,
            icon: FontAwesomeIcons.whatsapp,
            color: Color(0xFF25D366),
            onPressed: () => openwhatsapp(context, person.phoneNumber!),
          ),
          // Add other social icons here as needed
        ],
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context,
      {required IconData icon,
      required Color color,
      required Function onPressed}) {
    return Platform.isIOS
        ? CupertinoButton(
            child: FaIcon(icon, color: color, size: 30),
            onPressed: () => onPressed(),
            padding: EdgeInsets.zero,
          )
        : TextButton(
            child: FaIcon(icon, color: color),
            onPressed: () => onPressed(),
          );
  }

  Widget _buildFunctions() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Functions',
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold),
          ),
          Divider(height: 15, thickness: 2, endIndent: 200),
          Padding(
            padding: const EdgeInsets.only(top: 2.0, bottom: 15.0, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: person.functions
                  .map((function) =>
                      Text('- $function', style: TextStyle(fontSize: 15.0)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRotaryClubDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rotary Club',
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold),
          ),
          Divider(height: 15, thickness: 2, endIndent: 250),
          Text('Club District: ${person.district}',
              style: TextStyle(fontSize: 15.0)),
          Text('Club name: ${person.club}', style: TextStyle(fontSize: 15.0)),
        ],
      ),
    );
  }

  Widget _buildAboutMe() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About me',
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          Divider(height: 15, thickness: 2, endIndent: 280),
          Padding(
            padding: const EdgeInsets.only(right: 30, top: 5),
            child: Text(person.bio, style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOptions() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 30, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          person.email == null
              ? SizedBox.shrink()
              : _buildContactButton(
                  icon: FontAwesomeIcons.envelope,
                  color: Colors.black,
                  backgroundColor: Colors.grey.shade200,
                  onPressed: () async {
                    final email = Uri.parse('mailto:${person.email}');
                    if (await canLaunchUrl(email)) {
                      launchUrl(email);
                    } else {
                      throw 'Could not launch $email';
                    }
                  },
                ),
          person.phoneNumber == null
              ? SizedBox.shrink()
              : _buildContactButton(
                  icon: FontAwesomeIcons.phone,
                  color: Colors.white,
                  backgroundColor: Colors.blue.shade400,
                  borderColor: Colors.blue.shade100,
                  onPressed: () async {
                    final sms = Uri.parse('tel:${person.phoneNumber}');
                    if (await canLaunchUrl(sms)) {
                      launchUrl(sms);
                    } else {
                      throw 'Could not launch $sms';
                    }
                  },
                  isWide: true,
                  text: 'Call me',
                ),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    Color? borderColor,
    required VoidCallback onPressed, // Changed Function to VoidCallback
    bool isWide = false,
    String? text,
  }) {
    return Container(
      height: 65.0,
      width: isWide ? 180.0 : 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isWide ? 35.0 : 30.0),
        color: backgroundColor,
        border: borderColor != null
            ? Border.all(color: borderColor, width: 5)
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isWide ? 35.0 : 30.0),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FaIcon(icon, color: color, size: 30),
            if (isWide && text != null)
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  text,
                  style: TextStyle(color: color, fontSize: 18.0),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
