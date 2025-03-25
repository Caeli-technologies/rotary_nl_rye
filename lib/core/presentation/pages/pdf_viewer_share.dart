// 🎯 Dart imports:
import 'dart:async';
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class PDFPageWithShare extends StatefulWidget {
  final String pdfUrl;

  PDFPageWithShare({required this.pdfUrl});

  @override
  _PDFPageWithShareState createState() =>
      _PDFPageWithShareState(pdfUrl: pdfUrl);
}

class _PDFPageWithShareState extends State<PDFPageWithShare> {
  final String pdfUrl;

  _PDFPageWithShareState({required this.pdfUrl});

  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  void initState() {
    super.initState();
    // _createDynamicLink(pdfUrl);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _pageCountController.close();
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
        actions: [
          Container(
            child: PopupMenuButton<int>(
              itemBuilder: (context) => [
                // PopupMenuItem<int>(
                //   value: 0,
                //   child: Row(
                //     children: [
                //       Icon(CupertinoIcons.share, color: Palette.lightIndigo),
                //       const SizedBox(width: 7),
                //       Text('Share in-app Link'),
                //     ],
                //   ),
                // ),
                // PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.filePdf,
                          color: Palette.lightIndigo),
                      const SizedBox(width: 7),
                      Text('Share Document'),
                    ],
                  ),
                ),
              ],
              onSelected: (item) => _selectedItem(context, item),
              icon: FaIcon(FontAwesomeIcons.list,
                  color: Palette.indigo, size: 22.0),
            ),
          ),
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
              child: CircularPercentIndicator(
                animation: true,
                animateFromLastPercent: true,
                radius: 80.0,
                lineWidth: 8.0,
                percent: progress / 100,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${progress.round()}%',
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
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.grey[400],
                    ),
                    child: Text(
                      snapshot.data!,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  // Future<void> _createDynamicLink(String pdfUrl) async {
  //   setState(() {});

  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //     uriPrefix: 'https://rotarynl.page.link',
  //     link: Uri.parse('https://rotarynl.page.link/pdfUrl?url=$pdfUrl'),
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

  //   if (mounted) {
  //     setState(() {
  //       _linkMessage = url.toString();
  //     });
  //   }
  // }

  Future<void> _selectedItem(BuildContext context, int item) async {
    // _createDynamicLink(pdfUrl);

    switch (item) {
      case 0:
        // if (_linkMessage != null && await canLaunchUrlString(_linkMessage!)) {
        //   await Share.share(
        //     'Hierbij verstuur ik een linkje van een Document: $_linkMessage',
        //     subject: 'Look at this nice app :)',
        //   );
        // } else {
        //   throw 'Could not launch $_linkMessage';
        // }
        break;
      case 1:
        Directory tempDir = await getTemporaryDirectory();
        String fileName = pdfUrl.split('/').last;
        final path = '${tempDir.path}/$fileName';

        await Dio().download(pdfUrl, path);

        await Share.shareXFiles([XFile(path)], subject: fileName);

        break;
    }
  }
}
