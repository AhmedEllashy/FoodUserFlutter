import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            children: [
              _topInfoSection(),
              _notificationTypeSection(),
              const SizedBox(
                height: AppSize.s35,
              ),
              _notificationsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topInfoSection() {
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

  Widget _notificationTypeSection() {
    return Container(
      width: double.infinity,
      height: AppSize.s50,
      margin: const EdgeInsets.only(top: AppSize.s50),
      decoration: BoxDecoration(
        border:
            const Border.fromBorderSide(BorderSide(color: AppColors.primary)),
        borderRadius: BorderRadius.circular(AppSize.s20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: AppSize.s160,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              border:
                  Border.fromBorderSide(BorderSide(color: AppColors.primary)),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s20),
                  bottomLeft: Radius.circular(AppSize.s20)),
            ),
            child: Center(
              child: Text(
                AppStrings.delivery,
                style: getRegularTextStyle(
                    color: AppColors.white, fontSize: AppFontSizes.f16),
              ),
            ),
          ),
          Container(
            width: AppSize.s150,
            decoration: const BoxDecoration(),
            child: Center(
              child: Text(
                AppStrings.newsAndUpdates,
                style: getRegularTextStyle(
                    color: AppColors.primary, fontSize: AppFontSizes.f16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationsSection() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return _notificationDetails();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: AppSize.s10,
            );
          },
          itemCount: 3),
    );
  }

  Widget _notificationDetails(){
    return Container(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.sweDish,
                    style: getBoldTextStyle(fontSize: AppFontSizes.f18),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Text(
                    'on The way',
                    style: getRegularTextStyle(fontSize: AppFontSizes.f14,color: AppColors.black,fontWeight: AppFontWeights.w4),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '3:09 PM',
                        style: getRegularTextStyle(fontSize: AppFontSizes.f14,color: AppColors.grey),
                      ),
                    ],
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
