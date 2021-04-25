import 'dart:ui';

import 'package:flutter/material.dart';

class Device {
  Device._();
  static final Device instance = Device._();

  static double width = 0;
  static double height = 0;
  static bool isDark = false;
}

class Palette {
  Palette._();
  static final Palette _instance = Palette._();

  static Color indigo = 0 as Color;
  static Color themeShadeColor = 0 as Color;
  static Color accentColor = 0 as Color;
  static Color grey = 0 as Color;
  static Color lightIndigo = 0 as Color;

  static Palette get instance {
    _instance.set();
    return _instance;
  }

  set() {
    accentColor = Color.fromRGBO(57, 182, 245, 1);
    grey = Colors.grey[600]!;
    lightIndigo = Colors.indigo[100]!;

    if (Device.isDark) {
      indigo = Colors.indigo[400]!;
      themeShadeColor = Colors.grey[800]!;
    }
    else {
      indigo = Colors.indigo[800]!;
      themeShadeColor = Colors.grey[100]!;
    }
  }
}