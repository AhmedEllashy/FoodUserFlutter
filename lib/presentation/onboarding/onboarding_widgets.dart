import 'package:flutter/material.dart';
import 'package:food_user/domain/models/onboarding_model.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/styles_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';

final List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    AppAssets.onBoardingAssetOne,
    AppStrings.onBoardingTitleOne,
    AppStrings.onBoardingDescriptionOne,
  ),
  OnBoardingModel(
    AppAssets.onBoardingAssetTwo,
    AppStrings.onBoardingTitleTwo,
    AppStrings.onBoardingDescriptionTwo,
  ),
  OnBoardingModel(
    AppAssets.onBoardingAssetThere,
    AppStrings.onBoardingTitleThere,
    AppStrings.onBoardingDescriptionThere,
  ),
];

Widget getOnBoardingContent(int index , BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppPadding.p10),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(onBoardingList[index].image),
        const SizedBox(
          height: AppSize.s12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < onBoardingList.length; i++) getShape(index, i),
          ],
        ),
        const SizedBox(
          height: AppSize.s12,
        ),
        Text(
          onBoardingList[index].title,
          style: getBoldTextStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Text(
          onBoardingList[index].description,
          style: getRegularTextStyle(),
          textAlign: TextAlign.center,

        ),
        const SizedBox(
          height: AppSize.s30,
        ),
        skipButton(context),
        const SizedBox(
          height: AppSize.s30,
        ),
        Text(AppStrings.skip,style: getRegularTextStyle(color:AppColors.black,fontSize: AppFontSizes.f16,fontWeight: AppFontWeights.w3),),

      ],
    ),
  );
}

Widget getShape(int pageIndex , shapeIndex) {
  return Container(
    height:  pageIndex == shapeIndex  ? AppSize.s12 :AppSize.s8  ,
    width: pageIndex == shapeIndex  ? AppSize.s16 :AppSize.s10,
    margin: EdgeInsets.symmetric(horizontal: AppSize.s3),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: pageIndex != shapeIndex ? AppColors.grey.withOpacity(AppDecimal.d_4)  : Colors.transparent,
      border: Border.all(color:pageIndex != shapeIndex ?AppColors.grey.withOpacity(AppDecimal.d_3) : AppColors.black,width: AppDecimal.d_3),
    ),
    child: Padding(
      padding: const EdgeInsets.all(AppSize.s1_5),
      child: CircleAvatar(
      radius: AppSize.s8,
        backgroundColor: pageIndex == shapeIndex ? AppColors.black : Colors.transparent,
      ),
    ),
  );
}

Widget skipButton(BuildContext context) {
  return Container(
    height: AppSize.s80,
    width: AppSize.s100,
    decoration: const  BoxDecoration(
      color: AppColors.primary,
      shape: BoxShape.circle,

    ),
    child: ElevatedButton(

      style: ElevatedButton.styleFrom(
        shape:const CircleBorder(),
        primary:  AppColors.primary,
        onPrimary: Colors.amber,
        elevation: 20,  // Elevation
        shadowColor:  AppColors.primary.withOpacity(.9), // Shadow Color
      ),
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.preLoginRoute);

      },
      child: const Icon(
        Icons.arrow_back,
        color: AppColors.white,
        textDirection: TextDirection.rtl,
      ),
    ),
  );
}
