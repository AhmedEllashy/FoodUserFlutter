
import 'package:flutter/material.dart';

enum LanguageType{
  ENGLISH,
  ARABIC
}
const String english = 'en';
const String arabic = 'ar';
const String ASSETS_PATH_TRANSLATION = "assets/translations";
const Locale ARABIC_LOCALE = Locale('ar' ,'EG' );
const Locale ENGLISH_LOCALE = Locale('en' ,'US' );


extension GetAppLanguage on LanguageType{
  String getLanguage(){
    switch(this){

      case LanguageType.ENGLISH:
       return english;
      case LanguageType.ARABIC:
        return arabic;
    }
  }
}