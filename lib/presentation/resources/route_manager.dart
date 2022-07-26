import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_user/presentation/login/login_view.dart';
import 'package:food_user/presentation/onboarding/onboarding_view.dart';
import 'package:food_user/presentation/pre_login/pre_login_view.dart';
import 'package:food_user/presentation/product_details/product_details_view.dart';
import 'package:food_user/presentation/registration/registration_view.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/splash/spalsh_view.dart';

import '../main/main_view.dart';


class AppRoutes{
  static const String splashRoute= '/splash';
  static const String mainRoute= '/main';
  static const String loginRoute= '/login';
  static const String registerRoute= '/register';
  static const String onBoardingRoute= '/onBoarding';
  static const String productDetailsRoute= '/productDetails';
  static const String preLoginRoute= '/preLogin';



}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case AppRoutes.mainRoute :
          return MaterialPageRoute(builder:(context)=>const MainView());

    case AppRoutes.loginRoute :
        return MaterialPageRoute(builder:(context)=>  const LoginView());
      case AppRoutes.productDetailsRoute :
        return MaterialPageRoute(builder:(context)=>  const ProductDetailsView());
      case AppRoutes.registerRoute :
        return MaterialPageRoute(builder:(context)=> const RegistrationView());
      case AppRoutes.splashRoute :
        return MaterialPageRoute(builder:(context)=>const SplashView());
      case AppRoutes.onBoardingRoute :
        return MaterialPageRoute(builder:(context)=>const OnBoardingView());
      case AppRoutes.preLoginRoute :
        return MaterialPageRoute(builder:(context)=>const PreLoginView());


        default:
          return undefinedRoute();

    }
  }

  static Route<dynamic> undefinedRoute(){
    return MaterialPageRoute(builder: (context)=> const Scaffold(
      body: Text(AppStrings.errorRoute),
    ));
  }
}