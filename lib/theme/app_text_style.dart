import 'package:flutter/material.dart';

class AppTextStyle {
  static const String fontName = 'NeoSansArabic';

  static TextTheme textThemeLight = const TextTheme(
    displayLarge: TextStyle(
        fontSize: 105, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    displayMedium: TextStyle(
        fontSize: 66, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    displaySmall: TextStyle(fontSize: 52, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(
        fontSize: 37, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
    headlineSmall: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    titleLarge: TextStyle(
        fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    titleMedium: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyLarge: TextStyle(
        fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyMedium: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    bodySmall: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    labelLarge: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    labelMedium: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    labelSmall: TextStyle(
        fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );
}
// {
// FontWeight.w100: 'Thin',
// FontWeight.w200: 'ExtraLight',
// FontWeight.w300: 'Light',
// FontWeight.w400: 'Regular',
// FontWeight.w500: 'Medium',
// FontWeight.w600: 'SemiBold',
// FontWeight.w700: 'Bold',
// FontWeight.w800: 'ExtraBold',
// FontWeight.w900: 'Black',
// }
