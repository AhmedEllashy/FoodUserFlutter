import 'package:flutter/material.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';

ThemeData getAppTheme(){
  return ThemeData(
  primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(

    ),
    // canvasColor: Colors.white10,
    // colorScheme: ColorScheme(
    //   primary: Colors.green, brightness: Brightness.light,
    // ),
    elevatedButtonTheme:  ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.primary),
      ),
    ),
  );
}