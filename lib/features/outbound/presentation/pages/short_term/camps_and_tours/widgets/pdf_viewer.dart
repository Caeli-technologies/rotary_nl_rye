// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/circle_progress_bar_news.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

// ignore: import_of_legacy_library_into_null_safe

class PDFPageViewer extends StatefulWidget {
  final String title;
  final String pdfURL;

  PDFPageViewer({
    required this.pdfURL,
    required this.title,
  });
  @override
  _PDFPageViewerState createState() => _PDFPageViewerState(pdfURL: pdfURL);
}

class _PDFPageViewerState extends State<PDFPageViewer> {
  final String pdfURL;
  _PDFPageViewerState({required this.pdfURL});

  String title = 'Loading';

  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  void initState() {
    super.initState();
    // loadDocument();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color foreground = Colors.green;
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: UniformBackButton(),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.copy,
                  color: Palette.indigo,
                ),
                onPressed: () {
                  Clipboard.setData(new ClipboardData(text: 'Your Copy text'))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Copied to your clipboard !',
                          style: TextStyle(
                              color:
                                  (MediaQuery.of(context).platformBrightness ==
                                          Brightness.light)
                                      ? Colors.black
                                      : Colors.white)),
                      backgroundColor:
                          (MediaQuery.of(context).platformBrightness ==
                                  Brightness.light)
                              ? Colors.grey[350]
                              : Palette.themeShadeColor,
                    ));
                  });
                })
          ],
          title: Text(
            widget.title,
            textScaleFactor: 1.0,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
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
              pdfURL,
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
                          '$progress%',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Palette.bodyText,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'COMPLETED',
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
}
