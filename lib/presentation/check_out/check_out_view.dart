import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_cubit.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_states.dart';
import 'package:food_user/presentation/resources/route_manager.dart';

import '../../app/constants.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../resources/widgets_manager.dart';

class CheckOutView extends StatefulWidget {
  String ? subTotal;
  String ? delivery;
  String ? total;
   CheckOutView({Key? key ,this.subTotal,this.delivery,this.total,}) : super(key: key);

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  final TextEditingController _couponTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s12),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _topBarSection(),
                const SizedBox(
                  height: AppSize.s10,
                ),
                _cardSection(),
                const SizedBox(
                  height: AppSize.s50,
                ),
                _couponSection(),

                _bottomFeesSection(),
                _bottomButton(),


              ],
            ),
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
            child: Icon(
              Icons.arrow_back_ios_new,
              textDirection: TextDirection.ltr,
              size: AppSize.s18,
              color: AppColors.black,
            ),
          ),
        ),
        Text(
          AppStrings.checkOut,
          style: getBoldTextStyle(color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _cardSection() {
    return CardWidget(
      cardNumber: "5593 3246 7384 0233",
      holderName: "Ahmad Ellashy",
      expiredDate: "02/25",
      cvv: "777",
    );
  }

  Widget _couponSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:20.0),
              child: _couponTextFormField(),
            )),
        Expanded( child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppButton(AppStrings.apply, () {},height:AppSize.s60 ,),
        )),
      ],
    );
  }

  Widget _bottomFeesSection() {
    // return BlocBuilder<CartCubit,CartStates>(
    //   builder:(context,state)=>
          return  Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.s16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.subTotal,
                  style: getRegularTextStyle(
                      color: AppColors.grey,
                      fontSize: AppFontSizes.f16,
                      fontWeight: AppFontWeights.w4,
                      letterSpacing: 0.0),
                ),
                Text(
                  '${AppConstants.dollar}${widget.subTotal}',
                  style: getRegularTextStyle(
                      color: AppColors.grey,
                      fontSize: AppFontSizes.f16,
                      fontWeight: AppFontWeights.w4,
                      letterSpacing: 0.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.s16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.delivery,
                  style: getRegularTextStyle(
                      color: AppColors.grey,
                      fontSize: AppFontSizes.f16,
                      fontWeight: AppFontWeights.w4,
                      letterSpacing: 0.0),
                ),
                Text(
                  '${AppConstants.dollar}10.99',
                  style: getRegularTextStyle(
                      color: AppColors.grey,
                      fontSize: AppFontSizes.f16,
                      fontWeight: AppFontWeights.w4,
                      letterSpacing: 0.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.s35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.total,
                  style: getRegularTextStyle(
                      color: AppColors.black,
                      fontSize: AppFontSizes.f22,
                      fontWeight: AppFontWeights.bold),
                ),
                Text(
                  '${AppConstants.dollar}${widget.total}',
                  style: getRegularTextStyle(
                      color: AppColors.black,
                      fontSize: AppFontSizes.f22,
                      fontWeight: AppFontWeights.bold),
                ),
              ],
            ),
          ),
        ],
      );
    // );
  }

  Widget _bottomButton() {
    return AppButton(AppStrings.checkOut, () {
      Navigator.pushNamed(context, AppRoutes.successRoute);
    });
  }

  Widget _couponTextFormField(){
    return TextFormField(
      controller: _couponTextEditingController,
      decoration: InputDecoration(
        prefixIcon:const Icon(Icons.card_giftcard,size: AppSize.s20,),
        hintText: AppStrings.couponCode,
        hintStyle: getTextStyle(
            AppColors.mainFontColor,
            AppFontSizes.f14,
            AppFontWeights.w3,
            AppSize.s1_5,
            AppSize.s1_5),
        fillColor: AppColors.white,
        filled: true,
        contentPadding: const EdgeInsets.all(AppSize.s20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide: const BorderSide(
              width: AppSize.s1,
              color: Colors.transparent,
        ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppSize.s2,
            color: AppColors.primary.withOpacity(AppDecimal.d_3),
          ),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: AppSize.s2, color: AppColors.error),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: AppSize.s2, color: AppColors.error),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
      ),
      onChanged: (value) {
        setState(() {
        });
      },
    );

  }



}
