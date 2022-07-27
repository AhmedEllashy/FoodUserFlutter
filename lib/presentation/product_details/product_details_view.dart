import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../app/constants.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  List<Widget> gradients = [
    Image.asset(
      AppAssets.onionIcon,
      fit: BoxFit.fill,
    ),
    Image.asset(
      AppAssets.carrotIcon,
    ),
    Image.asset(
      AppAssets.tomatoIcon,
    ),
    Image.asset(AppAssets.cucumberIcon),
  ];
  List<Color> gradientsBackgroundColors = [
    Colors.yellow.withOpacity(AppDecimal.d_3),
    Colors.pink.withOpacity(AppDecimal.d_3),
    AppColors.primary.withOpacity(AppDecimal.d_3),
    Colors.amber,
  ];
  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              _topImageSection(),
              _productDetailsSection(),
              _descriptionSection(),
              _gradientsSection(),
            ],
          ),
          _bottomSection(),
        ],
      ),
    );
  }

  Widget _topImageSection() {
    return SizedBox(
      height: AppSize.s400,
      child: Stack(
        children: [
        Container(
          height: AppSize.s320,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(AppDecimal.d_3),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            AppAssets.italianPizzaAsset,
            height: AppSize.s320,
          ),
        ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSize.s16, vertical: AppSize.s40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      debugPrint('Tapped');
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primary,
                    )),
                IconButton(
                    onPressed: () {
                      debugPrint('Tapped');
                    },
                    icon: const Icon(
                      Icons.favorite_outline,
                      color: AppColors.primary,
                    )),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _productDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.sweDish,
                style: getBoldTextStyle(fontSize: AppFontSizes.f25),
              ),
              const GetAppCounter(),
            ],
          ),
          Row(
            children: [
              Text(
                "33min .",
                style: getRegularTextStyle(
                    fontWeight: AppFontWeights.w4, fontSize: AppFontSizes.f14),
              ),
              const SizedBox(
                width: AppSize.s6,
              ),
              const FaIcon(
                FontAwesomeIcons.solidStar,
                color: AppColors.primary,
                size: AppSize.s14,
              ),
              Text(
                " 4.5",
                style: getRegularTextStyle(
                    fontWeight: AppFontWeights.w4, fontSize: AppFontSizes.f14),
              ),
              const SizedBox(
                width: AppSize.s6,
              ),
              const FaIcon(
                FontAwesomeIcons.fire,
                color: AppColors.primary,
                size: AppSize.s14,
              ),
              const SizedBox(
                width: AppSize.s6,
              ),
              Text(
                "456 Kcal",
                style: getRegularTextStyle(
                    fontWeight: AppFontWeights.w4, fontSize: AppFontSizes.f14),
              ),
            ],
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: AppSize.s16,
              width: AppSize.s60,
              decoration: BoxDecoration(
                color: Colors.red.shade100,
              ),
              child: Center(
                child: Text(
                  AppStrings.trending,
                  style: getRegularTextStyle(
                      color: Colors.red, fontSize: AppFontSizes.f8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.description,
            style: getBoldTextStyle(fontSize: AppFontSizes.f18),
          ),
          const SizedBox(
            height: AppSize.s8,
          ),
          Text(
            AppStrings.mealDescription,
            maxLines: 4,
            style: getRegularTextStyle(
                fontSize: AppFontSizes.f14,
                color: AppColors.grey,
                fontWeight: AppFontWeights.w4),
          ),
        ],
      ),
    );
  }

  Widget _gradientsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.inGradients,
            style: getBoldTextStyle(fontSize: AppFontSizes.f18),
          ),
          const SizedBox(
            height: AppSize.s14,
          ),
          Row(
            children: [
              for (int i = 0; i < gradients.length; i++)
                Container(
                  height: AppSize.s50,
                  width: AppSize.s50,
                  margin: EdgeInsets.only(right: AppMargin.m10),
                  decoration: BoxDecoration(
                    color: gradientsBackgroundColors[i],
                    borderRadius: BorderRadius.circular(AppSize.s14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: gradients[i],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomSection() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.s8),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  '${AppConstants.dollar}14',
                  style: getBoldTextStyle(fontSize: AppFontSizes.f26),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppSize.s6),
                  child: Text(
                    '.44',
                    style: getRegularTextStyle(
                        fontWeight: AppFontWeights.bold,
                        fontSize: AppFontSizes.f16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSize.s10),
              child: AppButton(
                AppStrings.addToCart,
                () {},
                width: AppSize.s240,
              ),
            )
          ],
        ),
      ),
    );
  }
}
