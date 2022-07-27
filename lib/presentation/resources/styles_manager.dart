import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';



TextStyle getTextStyle(Color color,double fontSize , FontWeight fontWeight,double letterSpacing ,double wordSpacing){
  return  TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing
  );
}

getRegularTextStyle({Color color = AppColors.grey,double fontSize =AppFontSizes.f12 , FontWeight fontWeight =AppFontWeights.w3 ,double letterSpacing =0.0 , double wordSpacing = 0.0}) {
  return getTextStyle(
  color, fontSize, fontWeight,letterSpacing,wordSpacing
  );
}

getMediumTextStyle({Color color = AppColors.mainFontColor,double fontSize =AppFontSizes.f16 , FontWeight fontWeight =AppFontWeights.w5 ,double letterSpacing =0.0, double wordSpacing = 0.0 }) {
  return getTextStyle(
    color,fontSize,fontWeight,letterSpacing,wordSpacing);
}

getBoldTextStyle({Color color = AppColors.mainFontColor,double fontSize =AppFontSizes.f18 , FontWeight fontWeight =AppFontWeights.bold ,double letterSpacing = 0.0 , double wordSpacing = 0.0 }) {
  return getTextStyle(color , fontSize, fontWeight,letterSpacing,wordSpacing);
}
