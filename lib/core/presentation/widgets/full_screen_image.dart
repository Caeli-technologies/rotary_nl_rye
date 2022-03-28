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
            Container(
              margin: EdgeInsets.only(right: 10, top: 5),
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Icon(
                  Icons.close,
                  color: Palette.accentColor,
                  size: 30.0,
                ),
                shape: new CircleBorder(),
                elevation: 2.0,
                fillColor: Palette.themeShadeColor,
                padding: const EdgeInsets.all(5.0),
              ),
            )
          ]),
      body: GestureDetector(
          child: Hero(
              tag: '',
              child: Center(
                child: CachedNetworkImage(
                  // height: 200,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: url,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
              )),
          onTap: () {
            // Navigator.pop(context);
          }),
    );
  }
}
