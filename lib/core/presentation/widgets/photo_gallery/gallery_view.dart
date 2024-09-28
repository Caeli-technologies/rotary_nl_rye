// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:dio/dio.dart';
import 'package:transparent_image/transparent_image.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/photo_gallery/view_photo_full_screen.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class GalleryViewPage extends StatefulWidget {
  @override
  _GalleryViewPageState createState() => _GalleryViewPageState();
}

class _GalleryViewPageState extends State<GalleryViewPage> {
  late List<String> imageList = [];
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    try {
      final response = await _dio.get(
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/archive/archive-images.json',
      );
      if (response.statusCode == 200) {
        setState(() {
          imageList = List<String>.from(response.data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
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
        title: Text(
          'Gallery View',
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          itemCount: imageList.length,
          itemBuilder: (context, index) => buildImageCard(context, index),
        ),
      ),
    );
  }

  Widget buildImageCard(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ViewPhotos(
                imageIndex: index,
                imageList: imageList,
                heroTitle: 'image$index',
              );
            },
            fullscreenDialog: true,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: imageList[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
