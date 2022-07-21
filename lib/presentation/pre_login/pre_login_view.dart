import 'package:flutter/material.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/styles_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

class PreLoginView extends StatefulWidget {
  const PreLoginView({Key? key}) : super(key: key);

  @override
  State<PreLoginView> createState() => _PreLoginViewState();
}

class _PreLoginViewState extends State<PreLoginView> {
  @override
  Widget build(BuildContext context) {
    return getContentScreen();
  }

  Widget getContentScreen() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s10),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    const EdgeInsets.only(left: AppSize.s50, top: AppSize.s100),
                child: Image.asset(
                  AppAssets.chef,
                  height: AppSize.s200,
                ),
              ),
              const SizedBox(
                height: AppSize.s22,
              ),
              Text(
                AppStrings.goodEvening,
                style: getBoldTextStyle(),
                // textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.s60),
                child: Text(
                  AppStrings.preLoginDescription,
                  style: getRegularTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: AppSize.s50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    AppStrings.signUp,
                    () {
                      Navigator.pushNamed(context, AppRoutes.registerRoute);
                    },
                    hasShadow: true,
                    width: AppSize.s150,
                    height: AppSize.s60,
                    color: AppColors.white,
                    shadowColor: AppColors.grey,
                    radius: AppSize.s30,
                  ),
                  const SizedBox(
                    width: AppSize.s30,
                  ),
                  AppButton(
                    AppStrings.login,
                    () {
                      Navigator.pushNamed(context, AppRoutes.loginRoute);
                    },
                    hasShadow: true,
                    width: AppSize.s150,
                    radius: AppSize.s30,
                    textColor: AppColors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s50,
              ),
              TextButton(
                onPressed: () {
                  //Todo add Navigate to Main View
                },
                child: Text(
                  AppStrings.guestVisit,
                  style: getBoldTextStyle(fontSize: AppFontSizes.f16),
                  // textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
