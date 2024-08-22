// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class FullScreenImage extends StatelessWidget {
  final String url;

  FullScreenImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12.withOpacity(0.8),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: SizedBox.shrink(),
        actions: [
          buildCloseButton(context),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: buildHeroImage(context),
      ),
    );
  }

  Widget buildCloseButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, top: 5),
      width: 40,
      height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.close,
          color: Palette.accentColor,
          size: 30.0,
        ),
        shape: CircleBorder(),
        elevation: 2.0,
        fillColor: Palette.themeShadeColor,
        padding: const EdgeInsets.all(5.0),
      ),
    );
  }

  Widget buildHeroImage(BuildContext context) {
    return Hero(
      tag: url,
      child: Center(
        child: CachedNetworkImage(
          width: MediaQuery.of(context).size.width,
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
              ),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
