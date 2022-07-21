import 'package:flutter/material.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: getContentScreen(),
    );
  }

  Widget getContentScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            children: [
              const SizedBox(
                height: AppSize.s40,
              ),
              sectionOne(),
              sectionTwo(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget sectionOne() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: AppColors.primary,
                size: AppSize.s22,
              ),
              Text(
                AppStrings.location,
                style: getBoldTextStyle(letterSpacing: AppSize.s1),
              ),
            ],
          ),
          const SizedBox(
            height: AppSize.s6,
          ),
          Text(
            AppStrings.california,
            style: getRegularTextStyle(fontWeight: AppFontWeights.w4),
          ),
        ],
      ),
      const Spacer(),
      Container(
        height: AppSize.s60,
        width: AppSize.s60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
          shape: BoxShape.rectangle,
          color: AppColors.primary.withOpacity(AppDecimal.d_8),
        ),
        child: Center(
          child: Image.asset(
            AppAssets.userAsset,
            height: AppSize.s50,
          ),
        ),
      ),
    ],
  );
}

Widget sectionTwo() {
  return Column(
    children: [
      const SizedBox(
        height: AppSize.s50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              height: AppSize.s60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s14),
                color: AppColors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: AppColors.grey,
                    ),
                    const SizedBox(
                      width: AppSize.s14,
                    ),
                    Text(
                      AppStrings.search,
                      style: getRegularTextStyle(color: AppColors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: AppSize.s14,
          ),
          Container(
            height: AppSize.s60,
            width: AppSize.s60,
            // margin: const EdgeInsets.only(top: AppMargin.m20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s14),
              shape: BoxShape.rectangle,
              color: AppColors.primary.withOpacity(AppDecimal.d_8),
            ),
            child: Center(
              child: Image.asset(
                AppAssets.filterAsset,
                height: AppSize.s30,
              ),
            ),
          )
        ],
      ),
    ],
  );
}
