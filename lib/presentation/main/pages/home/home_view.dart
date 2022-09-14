import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/app/constants.dart';
import 'package:food_user/data/Network/firebase_paths.dart';
import 'package:food_user/domain/logic/banner_bloc/banner_cubit.dart';
import 'package:food_user/domain/logic/banner_bloc/banner_state.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_cubit.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_state.dart';
import 'package:food_user/domain/logic/product_bloc/product_cubit.dart';
import 'package:food_user/domain/logic/product_bloc/product_state.dart';
import 'package:food_user/presentation/product_details/product_details_view.dart';
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
  void initState() {
    super.initState();
    ProductCubit.get(context).getAllProducts();
    BannerCubit.get(context).getAllBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: getContentScreen(),
    );
  }

  Widget getContentScreen() {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is GetAllProductFailedState) {
          debugPrint("error : ${state.message}");
          getFlashBar(state.message, context);
        }
        if (state is GetAllProductFailedState) {
          getFlashBar(state.message, context);
        }
        if (state is GetAllProductFailedState) {
          getFlashBar(state.message, context);
        }
      },
      builder: (context, state) => SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              children: [
                const SizedBox(
                  height: AppSize.s20,
                ),
                _topSection(),
                _searchSection(),
                BlocConsumer<BannerCubit, BannerState>(
                  listener: (context, state) {},
                  builder: (context, state) =>
                      state is GetAllBannersLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : state is GetAllBannersCompletedState
                              ? _bannerSection(state)
                              : const Text(AppStrings.noData),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                categoriesSection(),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.mostPopular,
                      style: getBoldTextStyle(),
                      textAlign: TextAlign.start,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.mostPopularRoute);
                      },
                      child: Text(
                        AppStrings.all,
                        style: getMediumTextStyle(color: AppColors.primary),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                state is GetAllProductCompletedState
                    ? _mostPopularProductsSection(state)
                    : state is GetAllProductLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text(AppStrings.noData),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topSection() {
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

  Widget _searchSection() {
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

  Widget _bannerSection(GetAllBannersCompletedState state) {
    final banners = state.banners;
    return CarouselSlider(
        items: banners.map((banner) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s22),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: banner.imageUrl ?? "",
              placeholder: (context, url) => Image.asset(
                AppAssets.imageIcon,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) =>
                  Image.asset(AppAssets.imageIcon, fit: BoxFit.cover),
            ),
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
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ));
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

  Widget _mostPopularProductsSection(GetAllProductCompletedState state) {
    final products = state.products;

    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddToCartCompletedState) {
          getFlashBar(AppStrings.successAddedToCart, context,
              backgroundColor: AppColors.green);
        }
        if (state is AddToCartFailedState) {
          getFlashBar(state.message, context);
        }
      },
      builder: (context, state) => Container(
        color: AppColors.backgroundColor,
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppSize.s2.toInt(),
                childAspectRatio: 2 / 3.6,
                mainAxisSpacing: AppSize.s30,
                crossAxisSpacing: AppSize.s10),
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetailsView(
                                  id: products[index].id!,
                                  prodName: products[index].name!,
                                  category: products[index].category!,
                                  price: products[index].price!,
                                  discount: products[index].discount!,
                                  imageUrl: products[index].imageUrl!,
                                  status: products[index].status!,
                                  amount: products[index].amount!,
                                  deliveryTime: products[index].deliveryTime!,
                                  description: products[index].description!,
                                )));
                  },
                  child: GetProductWidget(
                    () {
                      CartCubit.get(context).addToCart(
                          prodId: products[index].id ?? AppConstants.empty,
                          quantity: 1);
                    },
                    product: products[index],
                  ));
            }),
      ),
    );
  }
}
