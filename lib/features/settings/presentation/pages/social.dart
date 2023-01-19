// 🐦 Flutter imports:

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/uniform_widgets/rotary_list_tile.dart';
import 'package:rotary_nl_rye/core/presentation/uniform_widgets/rotary_list_view.dart';
import '../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';
import '../../../../core/presentation/utils.dart';

class SocialPage extends StatefulWidget {
  final int? id;

  SocialPage({this.id});

  @override
  _SocialPageState createState() => _SocialPageState(id: id);
}

class _SocialPageState extends State<SocialPage> {
  final int? id;

  _SocialPageState({this.id});

  Widget getImage() {
    return CachedNetworkImage(
      height: 55,
      width: 55,
      imageUrl:
          'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: 'Socials',
      body: RotaryListView(
        listTiles: [
          RotaryListTile(
            action: () async => await Utils.callUri(
              Uri.https('rotary.nl'),
            ),
            title: 'www.rotary.nl',
            leading: getImage(),
          ),
          RotaryListTile(
            action: () async => await Utils.callUri(
              Uri.https('rotaryyep.nl'),
              // TODO pin certificate https://developer.android.com/training/articles/security-config#CertificatePinning
            ),
            title: 'www.rotaryyep.nl',
            leading: getImage(),
          ),
        ],
      ),
    );
  }
}
