import 'package:flutter/material.dart';

import '/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData? appTheme() {
    return ThemeData(
      buttonTheme: buttonTheme(),
      iconButtonTheme: iconButtonTheme(),
      appBarTheme: appBarTheme(),
    );
  }

  // AppBar theme
  static AppBarTheme? appBarTheme() {
    return const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.blackColor,
      ),
    );
  }

  // Button theme
  static ButtonThemeData? buttonTheme() {
    return const ButtonThemeData(
      buttonColor: Colors.blue,
    );
  }

  // Icon Button Theme
  static IconButtonThemeData? iconButtonTheme() {
    return const IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStatePropertyAll(
          AppColors.blueColor,
        ),
        backgroundColor: MaterialStatePropertyAll(
          AppColors.blueColor,
        ),
      ),
    );
  }
}
