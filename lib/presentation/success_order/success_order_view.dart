import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../resources/styles_manager.dart';

class SuccessOrderView extends StatelessWidget {
  const SuccessOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: AppSize.s120,
              ),
              Image.asset(
                AppAssets.partyAsset,
                height: AppSize.s240,
              ),
              const SizedBox(
                height: AppSize.s50,
              ),
              Text(
                AppStrings.orderSuccessTitle,
                style: getBoldTextStyle(
                    fontSize: AppFontSizes.f20, letterSpacing: AppSize.s1_5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Text(
                AppStrings.orderSuccessDescription,
                style: getRegularTextStyle(
                    fontSize: AppFontSizes.f18, letterSpacing: AppSize.s1_5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSize.s10,
              ),
              Padding(
                padding: const EdgeInsets.all(AppSize.s20),
                child: AppButton(AppStrings.returnHome, () {
                  Navigator.pushNamed(context, AppRoutes.mainRoute);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
