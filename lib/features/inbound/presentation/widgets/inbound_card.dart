import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/prop.dart';
import '../pages/inbound_page.dart';
import '../../../home/presentation/widgets/card_item.dart';

class InboundCard extends CardItem {
  InboundCard()
      : super(
          icon: FaIcon(
            FontAwesomeIcons.planeArrival,
            color: Palette.lightIndigo,
            size: 35,
          ),
          title: Row(
            children: [
              Text(
                'To ',
                style: TextStyle(
                  fontSize: 14,
                  color: Palette.indigo,
                ),
              ),
              // airplain
              FaIcon(
                FontAwesomeIcons.arrowRightLong,
                color: Palette.lightIndigo,
                size: 20,
              ),
              SizedBox(
                width: 5,
              ),
              // NL
              SvgPicture.asset(
                'assets/icons/flags/nl.svg',
                height: 15,
                width: 15,
                fit: BoxFit.contain,
              ),
            ],
          ),
          pushTo: InboundPage(),
        );
}
