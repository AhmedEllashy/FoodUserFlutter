import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/widgets_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> banners = [
    Image.asset(
      AppAssets.bannerAsset,
      fit: BoxFit.cover,
      width: double.infinity,
    ),
    Image.asset(
      AppAssets.bannerAsset,
      fit: BoxFit.cover,
      width: double.infinity,
    ),
    Image.asset(
      AppAssets.bannerAsset,
      fit: BoxFit.cover,
      width: double.infinity,
    ),
  ];
  List<Widget> categoriesIcons = [
    Image.asset(AppAssets.pizzaIcon),
    Image.asset(AppAssets.sausageIcon),
    Image.asset(AppAssets.donutIcon),
    Image.asset(AppAssets.iceCreamIcon),
  ];
  List<Color> categoriesBackgroundColors = [
    Colors.yellow.withOpacity(AppDecimal.d_3),
    Colors.pink.withOpacity(AppDecimal.d_3),
    AppColors.primary.withOpacity(AppDecimal.d_3),
    Colors.amber,
  ];
  List<Color> categoriesTextColors = [
    Colors.brown,
    Colors.red,
    Colors.brown,
    AppColors.primary,
  ];
  List<String> categoriesTexts = [
    'Pizza',
    'Asian',
    'Donat',
    'Ice',
  ];

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
                height: AppSize.s20,
              ),
              sectionOne(),
              sectionTwo(),
              bannerSection(),
              const SizedBox(
                height: AppSize.s20,
              ),
              categoriesSection(),
              const SizedBox(
                height: AppSize.s20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text(
                AppStrings.mostPopular,
                style: getBoldTextStyle(),
                textAlign: TextAlign.start,
              )),
              const SizedBox(
                height: AppSize.s20,
              ),
              mostPopularProductsSection(),
            ],
          ),
        ),
      ),
    );
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
              AppAssets.userIcon,
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
          height: AppSize.s30,
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
                  AppAssets.filterIcon,
                  height: AppSize.s30,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
      ],
    );
  }

  Widget bannerSection() {
    return ClipRRect(
      child: CarouselSlider(
          items: banners.map((banner) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s22),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: banner,
            );
          }).toList(),
          options: CarouselOptions(
            height: AppSize.s120,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: AppSize.s3.toInt()),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          )),
    );
  }

  Widget categoriesSection() {
    return SizedBox(
      height: AppSize.s50,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: AppSize.s90,
            width: AppSize.s90,
            decoration: BoxDecoration(
              color: categoriesBackgroundColors[index],
              borderRadius: BorderRadius.circular(AppSize.s22),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categoriesTexts[index],
                  style: getRegularTextStyle(
                      color: categoriesTextColors[index],
                      fontSize: AppFontSizes.f12,
                      fontWeight: AppFontWeights.w4),
                ),
                const SizedBox(
                  width: AppSize.s10,
                ),
                SizedBox(
                  height: AppSize.s22,
                  child: categoriesIcons[index],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: AppSize.s16,
          );
        },
      ),
    );
  }

  Widget mostPopularProductsSection() {
    return Container(
      height: AppSize.s600,
      color: AppColors.backgroundColor,
      child: GridView.builder(
        itemCount: 20,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppSize.s2.toInt(),
              childAspectRatio: 2 / 3.6,
              mainAxisSpacing: AppSize.s30,
              crossAxisSpacing: AppSize.s10),
          itemBuilder: (context, index) {
            return InkWell(onTap: (){
              Navigator.pushNamed(context, AppRoutes.productDetailsRoute);
            },child: const GetProductWidget());
          }),
    );
  }
}
