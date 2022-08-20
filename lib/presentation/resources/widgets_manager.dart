import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/app/constants.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';

import '../../domain/logic/favourite_bloc/favourite_cubit.dart';
import '../../domain/logic/favourite_bloc/favourite_states.dart';
import '../../domain/models/product.dart';
import '../payment/add_card_view.dart';
import 'font_manager.dart';
import 'string_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final double width;
  final VoidCallback onTapped;
  final double radius;
  final Color textColor;
  final Color borderColor;
  final bool hasIcon;
  final bool hasBorder;
  final bool hasShadow;
  final String icon;
  final Color shadowColor;

  const AppButton(
    this.text,
    this.onTapped, {
    Key? key,
    this.color = AppColors.primary,
    this.height = AppSize.s60,
    this.width = double.infinity,
    this.radius = AppSize.s16,
    this.textColor = AppColors.white,
    this.borderColor = AppColors.primary,
    this.icon = "",
    this.hasIcon = false,
    this.hasBorder = false,
    this.hasShadow = false,
    this.shadowColor = AppColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: hasBorder
            ? Border.all(color: borderColor)
            : Border.fromBorderSide(BorderSide.none),
        boxShadow: [
          hasShadow
              ? BoxShadow(
                  color: shadowColor.withOpacity(AppDecimal.d_5),
                  spreadRadius: AppSize.s4,
                  blurRadius: AppSize.s8,
                  offset: Offset(0, AppSize.s4), // changes position of shadow
                )
              : BoxShadow(),
        ],
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
          height: height,
          minWidth: width,
          onPressed: onTapped,
          child: hasIcon
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      icon,
                      height: AppSize.s30,
                    ),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                    Text(
                      text,
                      style: getRegularTextStyle(color: textColor),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: getTextStyle(textColor, AppFontSizes.f14,
                      AppFontWeights.w7, AppSize.s1_5, AppSize.s1_5),
                )),
    );
  }
}

class AppPhoneTextFormField extends StatelessWidget {
  final TextEditingController _controller;
  const AppPhoneTextFormField(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s45,
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          prefixIcon: CountryCodePicker(
            onChanged: print,
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: 'EG',
            favorite: ['+39', 'FR'],
            // optional. Shows only country name and flag
            showCountryOnly: false,
            showFlag: false,
            // optional. Shows only country name and flag when popup is closed.
            showOnlyCountryWhenClosed: false,
            // optional. aligns the flag and the Text left
            alignLeft: false,
            // showDropDownButton: true,
          ),
          hintText: AppStrings.phoneHint,
          hintStyle: getTextStyle(AppColors.secondaryFontColor,
              AppFontSizes.f14, AppFontWeights.w3, AppSize.s1_5, AppSize.s1_5),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: AppSize.s1_5,
                color: AppColors.grey.withOpacity(AppDecimal.d_3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: AppSize.s1_5,
                color: AppColors.primary.withOpacity(AppDecimal.d_3)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: AppSize.s1_5, color: AppColors.error),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        ),
      ),
    );
  }
}

class AppTextFormField extends StatefulWidget {
  final TextEditingController _controller;
  final String hint;
  final String label;
  final Icon icon;
  final bool hasBorder;

  bool isPassword;
  AppTextFormField(this._controller, this.icon,
      {Key? key, this.hint = '', this.isPassword = false, this.label = "",this.hasBorder = false})
      : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool showPassword = false;
  bool isObscure = false;
  @override
  void initState() {
    isObscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s70,
      child: TextFormField(

        controller: widget._controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.fieldRequired;
          } else {
            return null;
          }
        },
        obscureText: isObscure ? true : false,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: showPassword ? AppColors.primary : Colors.grey,
                  ))
              : null,
          prefixIcon: widget.icon,
          hintText: widget.hint,
          hintStyle: getTextStyle(AppColors.mainFontColor, AppFontSizes.f14,
              AppFontWeights.w3, AppSize.s1_5, AppSize.s1_5),
          enabledBorder: widget.hasBorder?OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s20),
            borderSide: BorderSide(
                width: AppSize.s1,
                color: AppColors.grey.withOpacity(AppDecimal.d_3)),
          ):InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: AppSize.s2,
              color: AppColors.primary.withOpacity(AppDecimal.d_3),
            ),
            borderRadius: BorderRadius.circular(AppSize.s20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: AppSize.s2, color: AppColors.error),
            borderRadius: BorderRadius.circular(AppSize.s20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: AppSize.s2, color: AppColors.error),
            borderRadius: BorderRadius.circular(AppSize.s20),
          ),
          // contentPadding:
          //     const EdgeInsets.symmetric(vertical: AppPadding.p14),
        ),
      ),
    );
  }
}

void getFlashBar(String message, BuildContext context,{Color backgroundColor = AppColors.error}) {
   Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.symmetric(
        horizontal: AppSize.s20, vertical: AppSize.s4),
  ).show(context);
}

 showProgressIndicator(BuildContext context){
     return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
}

class GetProductWidget extends StatelessWidget {
  final Product product;
  bool isFavourite;
  VoidCallback addToCart;
  GetProductWidget(
    this.addToCart, {
    Key? key,
        required this.product,
        this.isFavourite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit,FavouriteStates>(
      builder: (context,state)=>Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSize.s20)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    debugPrint("is Fav : $isFavourite");
                     isFavourite ?    FavouriteCubit.get(context).deleteFavouriteProduct(product.id ?? "") :
                     FavouriteCubit.get(context).setFavouriteProduct(product.id?? "") ;
                  },
                  icon: isFavourite?const Icon(
                    Icons.favorite,
                    size: AppSize.s18,
                    color: AppColors.primary,
                  ) :const Icon(
                    Icons.favorite_outline,
                    size: AppSize.s18,
                    color: AppColors.primary,
                  ), ),
            ),
            CachedNetworkImage(
              height: AppSize.s120,
              imageUrl: product.imageUrl ?? "",
              placeholder: (context, url) => Image.asset(AppAssets.imageIcon),
              errorWidget: (context, url, error) =>
                  Image.asset(AppAssets.imageIcon),
            ),
            Row(
              children: [
                Container(
                  height: AppSize.s16,
                  width: AppSize.s60,
                  decoration: BoxDecoration(
                      color: product.status == AppStrings.trending
                          ? Colors.red.shade100
                          : AppColors.primary.withOpacity(AppDecimal.d_2),
                      borderRadius: BorderRadius.circular(AppSize.s4)),
                  child: Center(
                    child: Text(
                      product.status ?? "",
                      style: getRegularTextStyle(
                          color: product.status == AppStrings.trending
                              ? Colors.red
                              : AppColors.primary,
                          fontSize: AppFontSizes.f8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                product.name ?? "",
                style: getBoldTextStyle(),
              ),
            ),
            const SizedBox(
              height: AppSize.s2,
            ),
            Row(
              children: [
                Text(
                  "${product.deliveryTime ?? ""} min .",
                  style: getRegularTextStyle(fontWeight: AppFontWeights.w4),
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
                  style: getRegularTextStyle(fontWeight: AppFontWeights.w4),
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${AppConstants.dollar}${product.price}',
                      style: getBoldTextStyle(fontSize: AppFontSizes.f20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppSize.s6),
                      child: Text(
                        ".${product.price}",
                        style:
                            getRegularTextStyle(fontWeight: AppFontWeights.bold),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: AppSize.s30,
                  width: AppSize.s30,
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: addToCart,
                    child: const FaIcon(
                      Icons.add,
                      color: AppColors.white,
                      size: AppSize.s14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GetAppCounter extends StatefulWidget {
  const GetAppCounter({Key? key}) : super(key: key);

  @override
  State<GetAppCounter> createState() => _GetAppCounterState();
}

class _GetAppCounterState extends State<GetAppCounter> {
  int counter = 1;
  double height = AppSize.s35;
  double width = AppSize.s35;

  @override
  Widget build(BuildContext context) {
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
}


class CardWidget extends StatelessWidget {
  String cardNumber;
  String holderName;
  String expiredDate;
  String cvv;

  CardWidget({Key? key,this.cardNumber = "",this.holderName = "",this.expiredDate = "",this.cvv = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s220,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s14),
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.payment,
                    color: AppColors.white,
                    size: AppSize.s30,
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: AppColors.white,
                    size: AppSize.s30,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.paymentColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSize.s20),
                    child: Text(
                      cardNumber,
                      style: getBoldTextStyle(
                          color: AppColors.white, letterSpacing: 2.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:AppSize.s14,vertical: AppSize.s16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment:Alignment.centerLeft,
                              child: Text(
                              AppStrings.cardHolder,
                                style: getBoldTextStyle(
                                    color: AppColors.grey,
                                    letterSpacing: 1,
                                    fontSize: AppFontSizes.f14),
                              ),
                            ),
                            const SizedBox(
                              height: AppSize.s6,
                            ),
                            Text(
                              holderName == "" ? AppStrings.nameHere :holderName ,
                              style: getBoldTextStyle(
                                  color: AppColors.white, letterSpacing: 1),
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                         Image.asset(AppAssets.masterCardAsset,height: AppSize.s50,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
Widget topBarSection(String title,BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      Container(
        height: AppSize.s45,
        width: AppSize.s45,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        child:  Center(
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              textDirection: TextDirection.ltr,
              size: AppSize.s18,
              color: AppColors.black,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
      ),
      Text(
        title,
        style: getBoldTextStyle(color: AppColors.grey),
      ),
    ],
  );
}

