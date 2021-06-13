import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:share_plus/share_plus.dart';

class PDFPage extends StatefulWidget {
  final String pdfUrl;

  PDFPage({required this.pdfUrl});

  @override
  _PDFPageState createState() => _PDFPageState(pdfUrl: pdfUrl);
}

class _PDFPageState extends State<PDFPage> {
  final String pdfUrl;

  _PDFPageState({required this.pdfUrl});

  bool _isLoading = true;
  late PDFDocument document;
  String title = "Loading";

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    setState(() {
      _isLoading = true;
      title = "Loading";
    });
    document = await PDFDocument.fromURL(pdfUrl);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
// TODO not yet working, Dynamic link to share this pdf page with someone else

          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       CupertinoIcons.share,
          //       color: Palette.indigo,
          //     ),
          //     onPressed: () {
          //       // Share.share(
          //       //     Platform.isIOS
          //       //         ? 'Hier mot nog een leuk stukje komen. + de link naar de Apple app store link https://example.com'
          //       //         : 'Hier mot nog een leuk stukje komen. + de link naar de google play store link https://example.com',
          //       //     subject: 'look at this nice app :)');
          //     },
          //   )
          // ],
        ),
        body: Center(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : PDFViewer(
                    document: document,
                    zoomSteps: 1,
                    //preload all pages
                    lazyLoad: false,
                    // scroll vertically
                    scrollDirection: Axis.vertical,
                    // numberPickerConfirmWidget: ,

                    //uncomment below code to replace bottom navigation with your own
                    /* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  }, */
                  )));
  }
}
