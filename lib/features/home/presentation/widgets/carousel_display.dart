import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../../../core/prop.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;

  List<CarouselModel> carousels = [
    CarouselModel(
        image:
            "assets/image/homepage/Informatiedag_Informatiemarkt_2021_homepage.jpg",
        text: "Informatiemarkt op 18 september a.s."),
    CarouselModel(
        image: "assets/image/homepage/welcom_to_the_netherlands_abbi.jpg",
        text: "Social actief zijn"),
    CarouselModel(
        image: "assets/image/homepage/together.jpg",
        text: "Vergroten van je Horizon"),
    CarouselModel(
        image: "assets/image/homepage/barbara_with_students.jpg",
        text: "Nieuwe vrienden maken"),
    CarouselModel(
        image: "assets/image/homepage/saying_goodby.jpg",
        text: "Jezelf nog beter leren kennen")
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
      margin: EdgeInsets.only(left: 16, right: 16),
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
              itemCount: carousels.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage(
                          carousels[index].image,
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue.shade900),
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          carousels[index].text,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
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
                              ? Palette.accentColor
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
