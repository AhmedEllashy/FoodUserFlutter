import 'package:flutter/material.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/styles_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((_) async{
      if(await _appPreferences.getOnBoardingWatched() ){
        if(await _appPreferences.getUserLoggedIn() ){
          Navigator.pushNamed(context, AppRoutes.mainRoute);

        }else{
          Navigator.pushNamed(context, AppRoutes.loginRoute);

        }
      }else{
        Navigator.pushNamed(context, AppRoutes.onBoardingRoute);

      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return getContentScreen();
  }

}
Widget getContentScreen(){
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Image.asset(AppAssets.logo),
    ),
  );
}


