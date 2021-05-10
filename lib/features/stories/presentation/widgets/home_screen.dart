// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/languages.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/models/carousel_model.dart';
import 'package:rotary_nl_rye/features/stories/presentation/widgets/home_cards_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body
      body: Container(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
                height: 90,
                margin:
                    EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 40),
                child: SvgPicture.asset(
                    'assets/image/rotary_rye_nl_logo_home.svg')),

            // idk if we need this but i will keep it for now
/*
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 24),
              child: Text(
                'Hi, NAME Some information for you!',
                style: TextStyle(fontSize: 16, color: Palette.lightIndigo),
              ),
            ),
*/

            // Slider images
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 190,
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
                                      : Palette.grey),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

/* 
            Padding(
              padding: EdgeInsets.only(left: 16, top: 24, bottom: 12),
              child: Text(
                'Let\'s Take a look (text still need to change!',
                style: TextStyle(fontSize: 12, color: Palette.lightIndigo),
              ),
            ),
*/
            SizedBox(
              height: 24,
            ),
            // navigator buttons
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      HomeCardsItem(
                          icon: FontAwesomeIcons.list,
                          title: 'Program',
                          description: 'information to apply and more things'),
                      HomeCardsItem(
                          icon: FontAwesomeIcons.reply,
                          title: 'Outbound',
                          description:
                              'students that are going to a diffrent country'),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      HomeCardsItem(
                          icon: FontAwesomeIcons.share,
                          title: 'Inbound',
                          description:
                              'people that are going to the netherlands'),
                      HomeCardsItem(
                          icon: FontAwesomeIcons.redoAlt,
                          title: 'Rebound',
                          description: 'rebound page'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
