import 'dart:ui';

import 'package:flutter/material.dart';

class Device {
  Device._();
  static final Device instance = Device._();

  static double width = 0;
  static double height = 0;
  static bool isDark = false;

  static String convert(int millisecondsSinceEpoch) {
    String result = "";

    List months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "September",
      "October",
      "November",
      "December"
    ];

    result += DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch)
        .day
        .toString();
    result += " ";
    result += months[
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch).month - 1];
    result += " ";
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
  static Color themeCardShadeColor = 0 as Color;
  static Color accentColor = 0 as Color;
  static Color grey = 0 as Color;
  static Color lightIndigo = 0 as Color;
  static Color imageBackgroundColor = 0 as Color;

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
      indigo = Colors.indigo[400]!;
      themeShadeColor = Colors.grey[800]!;
      themeCardShadeColor = Colors.grey[800]!;
    } else {
      indigo = Colors.indigo[800]!;
      themeShadeColor = Colors.grey[100]!;
      themeCardShadeColor = Colors.grey[200]!;
    }
  }
}
