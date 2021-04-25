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

  static Color main = 0 as Color;
  static Color tabBarBgColor = 0 as Color;
  static Color accentColor = 0 as Color;

  static Palette get instance {
    _instance.set();
    return _instance;
  }

  set() {
    accentColor = Color.fromRGBO(57, 182, 245, 1);

    if (Device.isDark) {
      main = Colors.indigo[400]!;
      tabBarBgColor = Colors.grey[800]!;
    }
    else {
      main = Colors.indigo[800]!;
      tabBarBgColor = Colors.grey[100]!;
    }
  }
}