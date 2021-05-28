import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'font_family.dart';

class AppTheme {
  static ThemeData appTheme() {
    return ThemeData(
      fontFamily: AppFonts.poppins,
      primaryColor: AppColors.primaryColor,
      backgroundColor: AppColors.backGroundColor,
      scaffoldBackgroundColor: AppColors.white,
      cardTheme: CardTheme(elevation: 1, margin: EdgeInsets.only()),
      accentColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
        color: AppColors.white,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
      ),
    );
  }
}
