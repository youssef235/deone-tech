import 'package:flutter/material.dart';

class AppColors {
  //TODO Define your colors here
  const AppColors();

  //you can used also color without define ColorHex
  //may add 0xFF + hexa code of color like
  static const Color primaryColor = Color(0xFFED6522);
  static const Color grayBorderColor = Color(0xFFD8D6D7);
  static const Color accentColor = Color(0xFF00C1DC);
  static const Color babyBluerColor = Color(0xFFD7FBFE);
  static const Color babyBluerWhiteColor = Color(0xFFF2FDFF);
  static const Color babyBluerDarkColor = Color(0xFFE4F0F3);
  static const Color red = Color(0xFFFF0000);
  static const Color blackTextB3b = Color(0xFF202B3B);
  static const Color blackTextB1A = Color(0xFF000B1A);
  static const Color blackGrey  = Color(0xFF3b3b3b);
  static const Color grayBackground = Color(0xFFFAFAFA);
  static const Color grayBlue = Color(0xFFDDE6F2);
  static const Color grayBorder = Color(0xFFB1B8C2);
  static const Color grayDark = Color(0xFF707A87);
  static const Color grayWhite = Color(0xFF999B9E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color blue = Color(0xFF0058C6);
  static const Color blue294 = Color(0xFF004294);
  static const Color red2F = Color(0xFFD32F2F);
  static const Color green6E = Color(0xFF40B96E);
  static const Color yellow = Color(0xFFF3B735);
  static const Color darkRed = Color(0xFF7A0E1F);

  static const Map<int, Color> gradientOrange = <int, Color>{
    50: Color(0xFFf7d7b4),
    100: Color(0xFFf5ccaa),
    200: Color(0xFFf3c19f),
    300: Color(0xFFf1b695),
    400: Color(0xFFf0af8d),
    500: Color(0xFFeea583),
    600: Color(0xFFed9c7a),
    700: Color(0xFFeb936e),
    800: Color(0xFFea8b65),
    900: Color(0xFFe88059)
  };
}

class ColorHex extends Color {
  ColorHex(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
