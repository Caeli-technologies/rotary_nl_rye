// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';

class PDFPage extends StatefulWidget {
  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  bool _isLoading = true;
  PDFDocument document;
  String title = "Loading";

  @override
  void initState() {
    super.initState();
    loadDocument(1);
  }

  loadDocument(value) async {
    setState(() {
      _isLoading = true;
      title = "Loading";
    });
    if (value == 1) {
      document = await PDFDocument.fromURL(
          "https://www.rotary.nl/yep/nieuws/nieuwsbrief-zomer-2020.pdf");
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
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
