import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';



TextStyle getTextStyle(Color color,double fontSize , FontWeight fontWeight,double letterSpacing){
  return  TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
    wordSpacing: AppSize.s1_5
  );
}

getRegularTextStyle({Color color = AppColors.grey,double fontSize =AppFontSizes.f12 , FontWeight fontWeight =AppFontWeights.w3 ,double letterSpacing =AppSize.s1_5  }) {
  return getTextStyle(
  color, fontSize, fontWeight,letterSpacing
  );
}

getMediumTextStyle() {
  return getTextStyle(
    AppColors.mainFontColor ,AppFontSizes.f16, AppFontWeights.w5,AppSize.s1_5 );
}

getBoldTextStyle({Color color = AppColors.mainFontColor,double fontSize =AppFontSizes.f18 , FontWeight fontWeight =AppFontWeights.bold ,double letterSpacing =AppSize.s1_5 }) {
  return getTextStyle(color , fontSize, fontWeight,letterSpacing);
}
