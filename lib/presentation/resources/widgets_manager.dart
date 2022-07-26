import 'package:another_flushbar/flushbar.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/app/constants.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';

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
                      AppFontWeights.w7, AppSize.s1_5),
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
              AppFontSizes.f14, AppFontWeights.w3, AppSize.s1_5),
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
  final IconData icon;
  bool isPassword;
  AppTextFormField(this._controller, this.icon,
      {Key? key, this.hint = '', this.isPassword = false, this.label = ""})
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
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.grey,
          ),
          hintText: widget.hint,
          hintStyle: getTextStyle(AppColors.mainFontColor, AppFontSizes.f14,
              AppFontWeights.w3, AppSize.s1_5),
          enabledBorder: InputBorder.none,
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //       width: AppSize.s1_5,
          //       color: AppColors.grey.withOpacity(AppDecimal.d_3)),
          // ),
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

void showFlashBar(String message, BuildContext context) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    backgroundColor: AppColors.error,
  ).show(context);
}

class GetProductWidget extends StatelessWidget {
  const GetProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.s20)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.heart,
                  size: AppSize.s18,
                )),
          ),
          Image.asset(
            AppAssets.italianPizzaAsset,
            height: AppSize.s120,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Row(
            children: [
              Container(
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
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.sweDish,
              style: getBoldTextStyle(),
            ),
          ),
          const SizedBox(
            height: AppSize.s2,
          ),
          Row(
            children: [
              Text(
                "24min .",
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
                    '${AppConstants.dollar}14',
                    style: getBoldTextStyle(fontSize: AppFontSizes.f20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.s6),
                    child: Text(
                      '.44',
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
                  onPressed: () {},
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
              borderRadius: BorderRadius.only(topLeft: Radius.circular(AppSize.s10),bottomLeft:Radius.circular(AppSize.s10 ),
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
              decoration:const  BoxDecoration(
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
              borderRadius: BorderRadius.only(topRight: Radius.circular(AppSize.s10),bottomRight:Radius.circular(AppSize.s10 ),

              ),),
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
