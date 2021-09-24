import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/photo_gallery/view_photo_full_screen.dart';

//TODO still need to add this somewhere

class GalleryViewPage extends StatefulWidget {
  @override
  _GalleryViewPageState createState() => _GalleryViewPageState();
}

class _GalleryViewPageState extends State<GalleryViewPage> {
  late List data;
  late List<String> imageList = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<String> fetchDataFromApi() async {
    var jsonData = await http.get(Uri.parse(
        "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/archive/archive-images.json"));
    var fetchData = jsonDecode(jsonData.body);

    setState(() {
      data = fetchData;
      data.forEach((element) {
        imageList.add(element);
      });
    });
    // print(imageList);
    return "Success";
  }

  // List<String> imageList = [
  //   'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/saying_goodby.jpg',
  //   // 'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
  //   // 'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
  //   // 'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&amp;k=6&amp;m=1059380230&amp;s=170667a&amp;w=0&amp;h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
  //   // 'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
  //   // 'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
  //   // 'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
  //   // 'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
  //   // 'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
  //   // 'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
  //   // 'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
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
          title: Text(
            "Gallery View",
            textScaleFactor: 1.2,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(12),
          child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              itemCount: imageList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) {
                                return ViewPhotos(
                                  imageIndex: index,
                                  imageList: imageList,
                                  heroTitle: "image$index",
                                );
                              },
                              fullscreenDialog: true));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: imageList[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ));
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
              }),
        ));
  }
}
