// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class PDFPageViewer extends StatefulWidget {
  final String title;
  final String pdfURL;

  PDFPageViewer({
    required this.pdfURL,
    required this.title,
  });

  @override
  _PDFPageViewerState createState() => _PDFPageViewerState();
}

class _PDFPageViewerState extends State<PDFPageViewer> {
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  void initState() {
    super.initState();
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

  Future<void> _sharePDF() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = widget.pdfURL.split('/').last;
      final filePath = '${tempDir.path}/$fileName';

      await Dio().download(widget.pdfURL, filePath);

      await Share.shareXFiles([XFile(filePath)], subject: fileName);
    } catch (e) {
      // Handle the error
      print('Error sharing PDF: $e');
    }
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
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.filePdf,
              color: Palette.indigo,
            ),
            onPressed: _sharePDF,
          ),
        ],
        title: Text(
          widget.title,
          textScaler: TextScaler.linear(1),
          style: TextStyle(
            color: Palette.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          PDF(
            onPageChanged: (int? current, int? total) {
              if (current != null && total != null) {
                _pageCountController.add('${current + 1} / $total');
              }
            },
            onViewCreated: (PDFViewController pdfViewController) async {
              _pdfViewController.complete(pdfViewController);
              final int currentPage =
                  await pdfViewController.getCurrentPage() ?? 0;
              final int? pageCount = await pdfViewController.getPageCount();
              if (pageCount != null) {
                _pageCountController.add('${currentPage + 1} / $pageCount');
              }
            },
          ).cachedFromUrl(
            widget.pdfURL,
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
                          '$progress %',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'COMPLETED',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    progressColor: Colors.green,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.grey[400],
                    ),
                    child: Text(
                      snapshot.data!,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
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
}
