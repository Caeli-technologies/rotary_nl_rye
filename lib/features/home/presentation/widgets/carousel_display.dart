// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:carousel_slider/carousel_slider.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;

  final List<CarouselModel> carousels = [
    CarouselModel(image: 'assets/image/homepage/Rebounddag_2024_Laren.png'),
    CarouselModel(image: 'assets/image/homepage/Inboundweekend_sept24.png'),
    CarouselModel(image: 'assets/image/homepage/Rotex24-25.png'),
    CarouselModel(image: 'assets/image/homepage/Aankomst_inbounds_aug24.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CarouselSlider.builder(
          itemCount: carousels.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    image: DecorationImage(
                      image: AssetImage(carousels[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            height: 220,
            autoPlay: true,
            enlargeCenterPage: true, // Makes the center image slightly larger
            viewportFraction:
                1, // Controls the width of each image (less than 1.0 to create gaps)
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carousels.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => setState(() {
                _current = entry.key;
              }),
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? Palette.indigo
                      : Palette.lightIndigo,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CarouselModel {
  final String image;
  final String? text;

  CarouselModel({required this.image, this.text});
}
