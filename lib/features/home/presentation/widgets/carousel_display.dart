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
    CarouselModel(
        image: 'assets/image/homepage/Informatiedag_14_september_2024.jpg',
        text: null),
    CarouselModel(
        image: 'assets/image/homepage/Koningsdag_Emmen_27_april_2024.png',
        text: null),
    CarouselModel(
        image:
            'assets/image/homepage/Nederland_herdenkt-inbounds_4_mei_2024.png',
        text: null),
    CarouselModel(
        image: 'assets/image/homepage/Inbounds_Bezoek_Beurs_van_Berlage.jpg',
        text: null),
    CarouselModel(
        image: 'assets/image/homepage/Farewell_Inbounds_2023-2024_mei_2024.jpg',
        text: null),
    CarouselModel(
        image: 'assets/image/homepage/Testimonial_Schouwen-Duiveland.png',
        text: null),
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
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                        image: DecorationImage(
                          image: AssetImage(carousels[index].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (carousels[index].text != null &&
                        carousels[index].text!.isNotEmpty)
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
                                color: Colors.black38,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  carousels[index].text!,
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
  final String image;
  final String? text;

  CarouselModel({required this.image, this.text});
}
