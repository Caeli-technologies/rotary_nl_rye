import 'package:flutter/material.dart';

class Device {
  Device._();
  static final Device instance = Device._();

  static double width = 0;
  static double height = 0;
  static bool isDark = false;

  static String convert(int millisecondsSinceEpoch) {
    String result = '';

    List months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'September',
      'October',
      'November',
      'December'
    ];

    result += DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)
        .day
        .toString();
    result += ' ';
    result += months[
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch).month - 1];
    result += ' ';
    result += DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)
        .year
        .toString();

    return result;
  }
}

class Palette {
  Palette._();
  static final Palette _instance = Palette._();

  static Color indigo = 0 as Color;
  static Color themeShadeColor = 0 as Color;
  static Color themeContactTabShadeColor = 0 as Color;
  static Color themeCardShadeColor = 0 as Color;
  static Color accentColor = 0 as Color;
  static Color grey = 0 as Color;
  static Color lightIndigo = 0 as Color;
  static Color imageBackgroundColor = 0 as Color;
  // text
  static Color titleText = 0 as Color;
  static Color bodyText = 0 as Color;
  // contact page
  static Color selectedlabelColor = 0 as Color;
  static Color unselectedLabelColor = 0 as Color;
  // FAQ page
  static Color isExpandedNo = 0 as Color;
  static Color isExpandedYes = 0 as Color;
  // Settings Page
  static Color emergencyRed = 0 as Color;
  static Color socialBlue = 0 as Color;
  // Calendar Page
  static Color imageBlox = 0 as Color;
  static Color imageShadowBox1 = 0 as Color;
  static Color imageShadowBox2 = 0 as Color;
  static Color descriptionText = 0 as Color;
  static Color creatorText = 0 as Color;
  static Color iconColor = 0 as Color;

  static Palette get instance {
    _instance.set();
    return _instance;
  }

  set() {
    accentColor = Color.fromRGBO(57, 182, 245, 1);
    grey = Colors.grey[600]!;
    lightIndigo = Colors.indigo[100]!;
    imageBackgroundColor = Color.fromRGBO(70, 197, 212, 1);

    if (Device.isDark) {
      // Dark
      indigo = Colors.indigo[400]!;
      themeShadeColor = Colors.grey[800]!;
      themeContactTabShadeColor = Colors.grey[850]!;
      themeCardShadeColor = Colors.grey[800]!;
      // text
      titleText = Colors.grey[350]!;
      bodyText = Colors.grey[300]!;
      // contact page
      selectedlabelColor = Colors.indigo[400]!;
      unselectedLabelColor = Colors.grey[500]!;
      // FAQ page
      isExpandedNo = Colors.indigo[100]!;
      isExpandedYes = Colors.indigoAccent[100]!;
      // Settings Page
      emergencyRed = Colors.red[600]!;
      socialBlue = Colors.blue;
      // Calendar Page
      imageBlox = Colors.grey[700]!;
      imageShadowBox1 = Colors.grey[850]!;
      imageShadowBox2 = Colors.grey.shade700;
      descriptionText = Colors.grey[300]!;
      creatorText = Colors.grey[400]!;
      iconColor = Colors.indigo[100]!;
    } else {
      // light
      indigo = Colors.indigo[800]!;
      themeShadeColor = Colors.grey[100]!;
      themeContactTabShadeColor = Colors.grey[50]!;
      themeCardShadeColor = Colors.grey[200]!;
      //text
      titleText = Colors.black87;
      bodyText = Colors.black;
      //contact page
      selectedlabelColor = Color(0xff525c6e);
      unselectedLabelColor = Color(0xffacb3bf);
      //FAQ page
      isExpandedNo = Colors.grey[700]!;
      isExpandedYes = Colors.indigo[700]!;
      // Settings Page
      emergencyRed = Colors.red[900]!;
      socialBlue = Colors.blue;
      // Calendar Page
      imageBlox = Colors.white;
      imageShadowBox1 = Colors.white;
      imageShadowBox2 = Colors.grey.shade400;
      descriptionText = Colors.black45;
      creatorText = Colors.black45;
      iconColor = Colors.indigoAccent[100]!;
    }
  }
}
// 042a49

Color kSecondaryBgColor = Colors.grey.shade100;
Color kSeperatorColor = Colors.grey.shade700;
double kBorderRadius = 10;
BoxShadow kBoxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(0, 7),
    blurRadius: 30,
    spreadRadius: 0);
BoxShadow kSubtleBoxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(0, 7),
    blurRadius: 20,
    spreadRadius: -2);
