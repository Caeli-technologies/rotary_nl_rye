// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/full_screen_image.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class ContributorsDetails extends StatelessWidget {
  final person;
  ContributorsDetails({required this.person});

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
                              child: Text(person.description,
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
                  ],
                ),
              ),
              person.websiteUrl == null &&
                      person.facebookUrl == null &&
                      person.instagramUrl == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 20.0, bottom: 0.0, right: 20),
                      child: Divider(
                        height: 15,
                        thickness: 2,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (person.instagramUrl != null)
                      _buildContactButton(
                        icon: FontAwesomeIcons.instagram,
                        color: Color(0xFFbc2a8d),
                        backgroundColor: Colors.transparent,
                        onPressed: () => launchUrlString(person.instagramUrl),
                      ),
                    if (person.linkedinUrl != null)
                      _buildContactButton(
                        icon: FontAwesomeIcons.linkedinIn,
                        color: Color(0xFF0e76a8),
                        backgroundColor: Colors.transparent,
                        onPressed: () => launchUrlString(person.linkedinUrl),
                      ),
                    if (person.githubUrl != null)
                      _buildContactButton(
                        icon: FontAwesomeIcons.github,
                        color: Color(0xFF000333),
                        backgroundColor: Colors.transparent,
                        onPressed: () => launchUrlString(person.githubUrl),
                      ),
                    if (person.websiteUrl != null)
                      _buildContactButton(
                        icon: FontAwesomeIcons.globe,
                        color: Color(0xFF0e76a8),
                        backgroundColor: Colors.transparent,
                        onPressed: () => launchUrlString(person.websiteUrl),
                      ),
                  ],
                ),
              ),
              person.websiteUrl == null &&
                      person.linkedinUrl == null &&
                      person.githubUrl == null &&
                      person.instagramUrl == null
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
                  'About me',
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
                  person.bio,
                  style: TextStyle(fontSize: 16.0),
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

  Widget _buildContactButton({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    Color? borderColor,
    required Function onPressed,
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
        onPressed: () => onPressed(),
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
