import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/app/constants.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../../resources/font_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Container(
          // margin: const EdgeInsets.all(AppSize.s10),
          padding: const EdgeInsets.all(AppSize.s20),
          child: Column(
            children: [
              _topBarSection(),
              const SizedBox(
                height: AppSize.s30,
              ),
              _cartProductsSection(),
              _bottomFeesSection(),
              _bottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBarSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //     Navigator.pop(context);
        // debugPrint('Tapped');
        Container(
          height: AppSize.s45,
          width: AppSize.s45,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSize.s14),
          ),
          child: const Center(
            child:  Icon(
              Icons.arrow_back_ios_new,
              textDirection: TextDirection.ltr,
              size: AppSize.s18,
              color: AppColors.black,
            ),
          ),
        ),
        Text(
          AppStrings.cart,
          style: getBoldTextStyle(color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _cartProductsSection() {
    return Expanded(
      child: ListView.separated(
        itemCount: 2,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(UniqueKey().toString()),
            direction: DismissDirection.horizontal,
            background: Container(
              decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(AppSize.s30)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [

                   Padding(
                     padding: EdgeInsets.symmetric(horizontal:AppSize.s14),
                     child: Icon(Icons.delete,color: AppColors.white,),
                   ),
                ],
              ),
            ),
            child: Container(
              height: AppSize.s100,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSize.s30)),
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.italianPizzaAsset,
                    height: AppSize.s120,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.sweDish,
                        style: getBoldTextStyle(fontSize: AppFontSizes.f18),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Text(
                        '${AppConstants.dollar}14.99',
                        style: getBoldTextStyle(fontSize: AppFontSizes.f18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: AppSize.s20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _counterRow(),
                      const SizedBox(
                        height: AppSize.s16,
                      ),
                      Text(
                        '${AppConstants.dollar}38.99',
                        style: getBoldTextStyle(fontSize: AppFontSizes.f18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: AppSize.s20,
          );
        },
      ),
    );
  }

  Widget _bottomFeesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical:AppSize.s16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.subTotal,
                style: getRegularTextStyle(color: AppColors.grey,fontSize: AppFontSizes.f16,fontWeight: AppFontWeights.w4,letterSpacing: 0.0),
              ),
              Text(
                '${AppConstants.dollar}60.99',
                style: getRegularTextStyle(color: AppColors.grey,fontSize: AppFontSizes.f16,fontWeight: AppFontWeights.w4,letterSpacing: 0.0),
              ),
            ],
          ),
        ),
        _dashLineWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:AppSize.s16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.delivery,
                style: getRegularTextStyle(color: AppColors.grey,fontSize: AppFontSizes.f16,fontWeight: AppFontWeights.w4,letterSpacing: 0.0),
              ),
              Text(
                '${AppConstants.dollar}10.99',
                style: getRegularTextStyle(color: AppColors.grey,fontSize: AppFontSizes.f16,fontWeight: AppFontWeights.w4,letterSpacing: 0.0),
              ),
            ],
          ),
        ),
        _dashLineWidget(),

        Padding(
          padding: const EdgeInsets.symmetric(vertical:AppSize.s35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.total,
                style: getRegularTextStyle(color: AppColors.black,fontSize: AppFontSizes.f22,fontWeight: AppFontWeights.bold),
              ),
              Text(
                '${AppConstants.dollar}109.99',
                style: getRegularTextStyle(color: AppColors.black,fontSize: AppFontSizes.f22,fontWeight: AppFontWeights.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomButton(){
    return  AppButton(AppStrings.reviewPayment, () { });

  }

  
  
  
  Widget _counterRow() {
    int counter = 1;
    double height = AppSize.s30;
    double width = AppSize.s30;

    return Row(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: const Border.fromBorderSide(const BorderSide(color: AppColors.black)),
            borderRadius: BorderRadius.circular(AppSize.s10),
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
              color: AppColors.black,
              size: AppSize.s14,
            ),
          ),
        ),
        Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Center(
              child: Text(
                '$counter',
                style: getBoldTextStyle(color: AppColors.black),
              ),
            )),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(AppSize.s10),
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
    );
  }
  Widget _dashLineWidget(){
    return const DottedLine(
      dashColor: AppColors.grey,
    );
  }
}
