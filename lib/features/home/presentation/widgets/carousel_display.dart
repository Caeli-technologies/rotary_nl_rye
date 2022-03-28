// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

// 🌎 Project imports:
import '../../../../core/prop.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;

  List<CarouselModel> carousels = [
    // CarouselModel(
    //     image: "assets/image/homepage/4bc2b606-ddf3-4c28-930d-e4d1ad8118d4.jpg",
    //     text: "Informatiedag online op 2 oktober a.s."),
    CarouselModel(
        image: 'assets/image/homepage/shelterbox.jpg',
        text: 'Social actief zijn'),
    CarouselModel(
        image: 'assets/image/b70db74b-aebe-470d-8c47-306640be9a00.jpg',
        text: 'Vergroten van je Horizon'),
    CarouselModel(
        image: 'assets/image/homepage/barbara_with_students.jpg',
        text: 'Nieuwe vrienden maken'),
    CarouselModel(
        image: 'assets/image/homepage/saying_goodby_2.jpeg',
        text: 'Jezelf nog beter leren kennen')
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            child: Swiper(
              onIndexChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              autoplay: true,
              layout: SwiperLayout.DEFAULT,
              scale: 1,
              itemCount: carousels.length,
              itemBuilder: (BuildContext context, index) {
                return Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        image: DecorationImage(
                            image: AssetImage(
                              carousels[index].image,
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                                color: Colors.black12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                carousels[index].text,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: map<Widget>(
                  carousels,
                  (index, image) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      height: 6,
                      width: 6,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Palette.indigo
                              : Palette.lightIndigo),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CarouselModel {
  final String image, text;

  CarouselModel({required this.image, required this.text});
}
