import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      textTheme: AppTextStyle.textThemeLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: AppColors.black, fontFamily: AppTextStyle.fontName),
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
        actionsIconTheme: IconThemeData(color: AppColors.primaryColor),
        // shape: RoundedRectangleBorder(
        //   side: BorderSide(color: AppColors.grayBorder)
        // )
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.grayWhite,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed));
}
