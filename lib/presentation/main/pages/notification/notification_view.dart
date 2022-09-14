import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/notification_bloc/notification_cubit.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../../../app/constants.dart';
import '../../../../domain/models/notification.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import 'package:intl/intl.dart';
class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  
  @override
  void initState() {
    super.initState();
    NotificationCubit.get(context).getAllNotifications();
  }
  getTime(Timestamp time){
    return DateFormat('hh:mm a').format(time.toDate());
  }
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
    return BlocConsumer<NotificationCubit, NotificationState>(
  listener: (context, state) {
    // if(state is GetNotificationFailedState){
    //   getFlashBar(state.error, context);
    // }
  },
  builder: (context, state) {
    return state is GetNotificationCompletedState ? Expanded(
      child:  ListView.separated(
          itemBuilder: (context, index) {
            return _notificationDetails(state.notifications,index);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: AppSize.s10,
            );
          },
          itemCount: state.notifications.length),
    ): state is GetNotificationLoadingState ? const Center(child: CircularProgressIndicator(),) : Center(child: Text("No Notification Yet"));
  },
);
  }

  Widget _notificationDetails(List<NotificationDataModel> notifications,int index){
    return Container(
      height: AppSize.s100,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.s30)),
      child: Row(
        children: [
         Image.asset(AppAssets.partyAsset,height: AppSize.s80,
         ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    notifications[index].notificationTitle!,
                    style: getBoldTextStyle(fontSize: AppFontSizes.f18),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Text(
                    notifications[index].notificationBody!,
                    style: getRegularTextStyle(fontSize: AppFontSizes.f14,color: AppColors.black,fontWeight: AppFontWeights.w4),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        getTime(notifications[index].notificationTimestamp!),
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
