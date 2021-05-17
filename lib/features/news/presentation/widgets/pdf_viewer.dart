// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';

// ignore: must_be_immutable
class PDFPage extends StatefulWidget {
  String pdfUrl;

  PDFPage({this.pdfUrl});

  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  final String pdfUrl;

  _PDFPageState({this.pdfUrl});

  bool _isLoading = true;
  PDFDocument document;
  String title = "Loading";

  @override
  void initState() {
    super.initState();
    loadDocument(0); // 0 = local fetch | 1 = web fetch
  }

  loadDocument(value) async {
    setState(() {
      _isLoading = true;
      title = "Loading";
    });
    if (value == 1) {
      // [VERBOSE-2:ui_dart_state.cc(186)] Unhandled Exception: NoSuchMethodError: The getter 'length' was called on null.
      // Receiver: null
      // Tried calling: length

      // document = await PDFDocument.fromURL(pdfUrl); // not yet working
      document = await PDFDocument.fromURL(
          "https://www.rotary.nl/yep/nieuws/nieuwsbrief-zomer-2020.pdf"); // works
    } else {
      document = await PDFDocument.fromAsset(
          'assets/pdf_test/nieuwsbrief-zomer-2020.pdf');
    }
    setState(() {
      title = (value == 1) ? "Loaded From Url" : "Loaded From Assets";
      _isLoading = false;
    });
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

                    //uncomment below code to replace bottom navigation with your own
                    /* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage()(page: 0);
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
