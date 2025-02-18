import 'package:evently/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      elevation: 0,
      // backgroundColor: Colors.transparent,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,

      shape: StadiumBorder(
        side: BorderSide(
          width: 6,
          color: AppColors.whiteColor,
        ),
      ),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(50),
      //   side: BorderSide(
      //     color: AppColors.whiteColor,
      //     width: 8,
      //   ),
      // ),
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      elevation: 0,
      // backgroundColor: Colors.transparent,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
      shape: StadiumBorder(
        side: BorderSide(
          width: 6,
          color: AppColors.whiteColor,
        ),
      ),
    ),
  );
}
