// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class Device {
  Device._();

  static final Device instance = Device._();

  static double width = 0;
  static double height = 0;
  static bool isDark = false;

  static String convert(int millisecondsSinceEpoch) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    const List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';
  }
}

class Palette {
  Palette._();

  static late Color indigo;
  static late Color themeShadeColor;
  static late Color themeContactTabShadeColor;
  static late Color themeCardShadeColor;
  static late Color accentColor;
  static late Color grey;
  static late Color lightIndigo;
  static late Color imageBackgroundColor;

  // text
  static late Color titleText;
  static late Color bodyText;

  // contact page
  static late Color selectedLabelColor;
  static late Color unselectedLabelColor;

  // FAQ page
  static late Color isExpandedNo;
  static late Color isExpandedYes;

  // Settings Page
  static late Color emergencyRed;
  static late Color socialBlue;

  // Calendar Page
  static late Color imageBlox;
  static late Color imageShadowBox1;
  static late Color imageShadowBox2;
  static late Color descriptionText;
  static late Color creatorText;
  static late Color iconColor;

  static void initialize(bool isDarkMode) {
    accentColor = const Color(0xFF39B6F5);
    grey = Colors.grey.shade600;
    lightIndigo = Colors.indigo.shade100;
    imageBackgroundColor = const Color(0xFF46C5D4);

    if (isDarkMode) {
      // Dark
      indigo = Colors.indigo.shade400;
      themeShadeColor = Colors.grey.shade800;
      themeContactTabShadeColor = Colors.grey[850]!;
      themeCardShadeColor = Colors.grey.shade800;
      // text
      titleText = Colors.grey[350]!;
      bodyText = Colors.grey.shade300;
      // contact page
      selectedLabelColor = Colors.indigo.shade400;
      unselectedLabelColor = Colors.grey.shade500;
      // FAQ page
      isExpandedNo = Colors.indigo.shade100;
      isExpandedYes = Colors.indigoAccent.shade100;
      // Settings Page
      emergencyRed = Colors.red.shade600;
      socialBlue = Colors.blue;
      // Calendar Page
      imageBlox = Colors.grey.shade700;
      imageShadowBox1 = Colors.grey[850]!;
      imageShadowBox2 = Colors.grey.shade700;
      descriptionText = Colors.grey.shade300;
      creatorText = Colors.grey.shade400;
      iconColor = Colors.indigo.shade100;
    } else {
      // Light
      indigo = Colors.indigo.shade800;
      themeShadeColor = Colors.grey.shade100;
      themeContactTabShadeColor = Colors.grey.shade50;
      themeCardShadeColor = Colors.grey.shade100;
      // text
      titleText = Colors.black87;
      bodyText = Colors.black;
      // contact page
      selectedLabelColor = const Color(0xFF525C6E);
      unselectedLabelColor = const Color(0xFFACB3BF);
      // FAQ page
      isExpandedNo = Colors.grey.shade700;
      isExpandedYes = Colors.indigo.shade700;
      // Settings Page
      emergencyRed = Colors.red.shade900;
      socialBlue = Colors.blue;
      // Calendar Page
      imageBlox = Colors.white;
      imageShadowBox1 = Colors.white;
      imageShadowBox2 = Colors.grey.shade400;
      descriptionText = Colors.black45;
      creatorText = Colors.black45;
      iconColor = Colors.indigoAccent.shade100;
    }
  }
}

// Common constants for styling
const Color kSecondaryBgColor = Color(0xFFF5F5F5);
const Color kSeparatorColor = Color(0xFFBDBDBD);
const double kBorderRadius = 10.0;
const BoxShadow kBoxShadow = BoxShadow(
  color: Color(0x1A000000),
  offset: Offset(0, 7),
  blurRadius: 30,
  spreadRadius: 0,
);
const BoxShadow kSubtleBoxShadow = BoxShadow(
  color: Color(0x14000000),
  offset: Offset(0, 4),
  blurRadius: 20,
  spreadRadius: -2,
);
