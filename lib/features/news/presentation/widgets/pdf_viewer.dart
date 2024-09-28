// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

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

  // String? _linkMessage;
  String? id;

  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  void initState() {
    super.initState();
    // _createDynamicLink(id = widget.data.id.toString());
    _removeBadge();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
  }

  void _removeBadge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('newsBadge', 0);
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
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: MediaQuery.of(context).platformBrightness,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: UniformBackButton(),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       CupertinoIcons.share,
          //       color: Palette.indigo,
          //     ),
          //     onPressed: _createShareURL,
          //   )
          // ],
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
                    CircularPercentIndicator(
                      animation: true,
                      animateFromLastPercent: true,
                      radius: 80.0,
                      lineWidth: 8.0,
                      percent: (progress / 100),
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${(progress).round()}%',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'COMPLETED',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      progressColor: Colors.green,
                    )
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

  // Future<void> _createDynamicLink(String id) async {
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //     uriPrefix: 'https://rotarynl.page.link',
  //     link: Uri.parse('https://rotarynl.page.link/news?id=$id'),
  //     androidParameters: AndroidParameters(
  //       packageName: 'com.caelitechnologies.rotary_nl_rye',
  //       minimumVersion: 1,
  //     ),
  //     iosParameters: IOSParameters(
  //       bundleId: 'com.caelitechnologies.rotary-nl-rye',
  //       minimumVersion: '1',
  //       appStoreId: '1567096118',
  //     ),
  //   );

  //   final ShortDynamicLink shortLink =
  //       await dynamicLinks.buildShortLink(parameters);
  //   final Uri url = shortLink.shortUrl;

  //   setState(() {
  //     _linkMessage = url.toString();
  //   });
  // }

  // _createShareURL() async {
  //   _createDynamicLink(id = widget.data.id.toString());

  //   if (await canLaunchUrlString(_linkMessage!)) {
  //     await Share.share(
  //         Platform.isIOS
  //             ? 'Hier mot nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage'
  //             : 'Hier mot nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage',
  //         subject: 'look at this nice app :)');
  //   } else {
  //     throw 'Could not launch $_linkMessage';
  //   }
  // }
}
