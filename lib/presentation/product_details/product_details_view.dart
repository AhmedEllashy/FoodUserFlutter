import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_cubit.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_state.dart';
import 'package:food_user/domain/logic/product_bloc/product_state.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../app/constants.dart';
import '../../domain/logic/product_bloc/product_cubit.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';

class ProductDetailsView extends StatefulWidget {
  String id;
  String prodName;
  String category;
  String price;
  String discount;
  int amount;
  String imageUrl;
  String status;
  String deliveryTime;
  String description;

  ProductDetailsView({
    Key? key,
    this.id = "",
    this.prodName = "",
    this.category = "",
    this.price = "",
    this.discount = "",
    this.status = "",
    this.amount = 0,
    this.imageUrl = "",
    this.deliveryTime = "",
    this.description = "",
  }) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int counter = 1;
  double height = AppSize.s35;
  double width = AppSize.s35;
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) => ListView(
          children: [
            _topImageSection(),
            _productDetailsSection(),
            _descriptionSection(),
            _gradientsSection(),
            _bottomSection(),
          ],
        ),
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
            child: CachedNetworkImage(
              height: AppSize.s320,
              imageUrl: widget.imageUrl,
              placeholder: (context, url) => Image.asset(
                AppAssets.imageIcon,
                height: AppSize.s120,
              ),
              errorWidget: (context, url, error) =>
                  Image.asset(AppAssets.imageIcon),
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

  Widget Counter() {
    return Container(
      child: Row(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s10),
                bottomLeft: Radius.circular(AppSize.s10),
              ),
            ),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  counter--;
                });
              },
              child: const FaIcon(
                Icons.remove,
                color: AppColors.white,
                size: AppSize.s14,
              ),
            ),
          ),
          Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Center(
                child: Text(
                  '$counter',
                  style: getBoldTextStyle(color: AppColors.white),
                ),
              )),
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppSize.s10),
                bottomRight: Radius.circular(AppSize.s10),
              ),
            ),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: const FaIcon(
                Icons.add,
                color: AppColors.white,
                size: AppSize.s14,
              ),
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
                widget.prodName,
                style: getBoldTextStyle(fontSize: AppFontSizes.f25),
              ),
              Counter(),
            ],
          ),
          Row(
            children: [
              Text(
                "${widget.deliveryTime}min.",
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
                  color: widget.status == AppStrings.trending
                      ? Colors.red.shade100
                      : AppColors.primary.withOpacity(AppDecimal.d_2),
                  borderRadius: BorderRadius.circular(AppSize.s4)),
              child: Center(
                child: Text(
                  widget.status,
                  style: getRegularTextStyle(
                      color: widget.status == AppStrings.trending
                          ? Colors.red
                          : AppColors.primary,
                      fontSize: AppFontSizes.f8),
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
            widget.description,
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
            BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (state is AddToCartFailedState) {
                  getFlashBar(state.message, context);
                } else if (state is AddToCartCompletedState) {
                  getFlashBar(AppStrings.successAddedToCart, context,
                      backgroundColor: AppColors.green);
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(AppSize.s10),
                  child: AppButton(
                    AppStrings.addToCart,
                    () {
                      CartCubit.get(context)
                          .addToCart(prodId: widget.id, quantity: counter);
                    },
                    width: AppSize.s240,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
