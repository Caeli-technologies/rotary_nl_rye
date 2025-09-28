// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class SocialPage extends StatelessWidget {
  final int? id;

  const SocialPage({Key? key, this.id}) : super(key: key);

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
        leading: const UniformBackButton(),
        title: Text(
          'Socials',
          style: TextStyle(
            color: Palette.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: <Widget>[
          buildLinkOptionRow(
            context,
            'www.rotary.nl',
            Palette.socialBlue,
            'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
            'http://www.rotary.nl/',
          ),
          const Divider(height: 15, thickness: 2),
          buildLinkOptionRow(
            context,
            'www.rotaryyep.nl',
            Palette.grey,
            'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
            'http://www.rotaryyep.nl/',
          ),
          const Divider(height: 15, thickness: 2),
        ],
      ),
    );
  }

  Widget buildLinkOptionRow(
    BuildContext context,
    String title,
    Color colour,
    String imageUrl,
    String linkUrl,
  ) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrlString(linkUrl)) {
          await launchUrlString(linkUrl);
        } else {
          throw 'Could not launch $linkUrl';
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CachedNetworkImage(
            height: 55,
            width: 55,
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: colour,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Palette.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
