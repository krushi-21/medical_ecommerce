import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles();

  static TextStyle get logintextstyle => TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.w500,
        fontSize: 34,
      );
  static TextStyle get shopTextStyle => TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 26,
      );
  static TextStyle get shopNameTextstyle => TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );
  static TextStyle get shopDescriptionTextstyle => TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w200,
        fontSize: 12,
      );
  static TextStyle get orderNowTextstyle => TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  static TextStyle get productNameTextstyle => TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static TextStyle get productPriceTextstyle => TextStyle(
        color: AppColors.deepBlue,
        fontWeight: FontWeight.w800,
        fontSize: 14,
      );
  //description page
  static TextStyle get productName2Textstyle => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: "Lato",
        fontSize: 24,
      );
  static TextStyle get productPrice2Textstyle => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: 22,
      );
  static TextStyle get productDescriptionTextstyle => TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.normal,
        fontSize: 10,
      );
  //Add products
  static TextStyle get addProductTextStyle =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
}
