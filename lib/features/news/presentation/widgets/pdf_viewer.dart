import 'dart:async';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rotary_nl_rye/core/presentation/widgets/circle_progress_bar_news.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PDFPage extends StatefulWidget {
  final News data;
  final String pdfUrl;

  PDFPage({required this.data, required this.pdfUrl});
  @override
  _PDFPageState createState() => _PDFPageState(pdfUrl: pdfUrl, data: data);
}

class _PDFPageState extends State<PDFPage> {
  final String pdfUrl;
  final News data;

  _PDFPageState({required this.pdfUrl, required this.data});

  String title = "Loading";

  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  String? _linkMessage;
  bool _isCreatingLink = false;
  String? id;

  @override
  void initState() {
    super.initState();
    // loadDocument();
    this._createDynamicLink(id = widget.data.id.toString());

    _removeBadge();
    print(pdfUrl);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
  }

  void _removeBadge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("newsBadge", 0);
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color foreground = Colors.green;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Container(
            margin: EdgeInsets.only(left: 10, top: 5),
            width: 40,
            height: 40,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Icon(
                Icons.arrow_back,
                color: Palette.accentColor,
                size: 30.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Palette.themeShadeColor,
              padding: const EdgeInsets.all(5.0),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                CupertinoIcons.share,
                color: Palette.indigo,
              ),
              onPressed: _createShareURL,
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            PDF(
              onPageChanged: (int? current, int? total) =>
                  _pageCountController.add('${current! + 1} / $total'),
              onViewCreated: (PDFViewController pdfViewController) async {
                _pdfViewController.complete(pdfViewController);
                final int currentPage =
                    await pdfViewController.getCurrentPage() ?? 0;
                final int? pageCount = await pdfViewController.getPageCount();
                _pageCountController.add('${currentPage + 1} / $pageCount');
              },
            ).cachedFromUrl(
              pdfUrl,
              placeholder: (progress) => Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircleProgressBar(
                          foregroundColor:
                              (progress >= 0.8) ? Colors.green : Colors.orange,
                          backgroundColor: foreground.withOpacity(0.2),
                          value: (progress / 100),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "$progress%",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Palette.bodyText,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "COMPLETED",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Palette.bodyText,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              errorWidget: (error) => Center(child: Text(error.toString())),
              maxAgeCacheObject: const Duration(days: 10),
            ),
            StreamBuilder<String>(
                stream: _pageCountController.stream,
                builder: (_, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Positioned(
                        top: 20,
                        right: 20,
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 4.0, left: 16.0, bottom: 4.0, right: 16.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.grey[400]),
                            child: Text(snapshot.data!,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400))));
                  }

                  return const SizedBox();
                }),
          ],
        ));
  }

  Future<void> _createDynamicLink(String id) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://rotarynl.page.link',
      link: Uri.parse(
          'https://rotarynl.page.link/news?id=$id'), //change this to the url in the main.dart
      androidParameters: AndroidParameters(
        packageName: 'com.caelitechnologies.rotary_nl_rye',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.caelitechnologies.rotary-nl-rye',
        minimumVersion: '1',
        appStoreId: '1567096118',
      ),
      // socialMetaTagParameters: SocialMetaTagParameters(
      //   title: 'Example of a Dynamic Link',
      //   description: 'This link works whether app is installed or not!',
      //   imageUrl: Uri.parse(
      //       'https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/6e/21/e4/6e21e45b-49cb-fa52-83c2-bb56ab288b49/AppIcon-0-0-1x_U007emarketing-0-0-0-4-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.jpeg/1200x630wa.png'),
      // ),
    );

    Uri url;
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    url = shortLink.shortUrl;

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  _createShareURL() async {
    _createDynamicLink(id = widget.data.id.toString());

    if (await canLaunch(_linkMessage!)) {
      await Share.share(
          Platform.isIOS
              ? 'Hier mot nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage' // iOS
              : 'Hier mot nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage', //android
          subject: 'look at this nice app :)');
    } else {
      throw 'Could not launch $_linkMessage';
    }
  }
}
