import 'package:flutter/material.dart';
import 'package:food_user/app/app_prefs.dart';

import '../../app/di.dart';
import 'onboarding_widgets.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  void initState() {
   _appPreferences.setOnBoardingWatched();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageView.builder(
            itemCount: onBoardingList.length,
            onPageChanged: (index){
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context,index){
             return getOnBoardingContent(index,context);
            },

          ),
        ),

    );
  }
}

