import 'package:flutter/material.dart';
import 'package:food_user/presentation/address/all_addresses/all_addresses_view.dart';
import 'package:food_user/presentation/order/orders_view/orders_view.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/styles_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../../resources/color_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(AppSize.s14),
        child: SafeArea(
          child: Column(
            children: [
              topBarSection(AppStrings.profile, context),
              const SizedBox(
                height: AppSize.s10,
              ),
              _profileImageSection(),
              const SizedBox(
                height: AppSize.s20,
              ),
              _buttonsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileImageSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Image.asset(AppAssets.userIcon),
          radius: AppSize.s60,
        ),
        const SizedBox(
          height: AppSize.s10,
        ),
        Text(
          "Ahmad Ellashy",
          style: getMediumTextStyle(),
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Builder(
          builder: (context) {
            return Container(
              height: AppSize.s60,
              width: AppSize.s140,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSize.s14),
              ),
              child: const Center(
                child: Icon(Icons.chat,color: AppColors.white,)
              ),
            );
          }
        ),
      ],
    );
  }

  Widget _buttonsSection() {
    return ListView(
      shrinkWrap: true,
      children: [
        profileButtonWidget(AppStrings.preferences, () {}, Icons.settings),
        profileButtonWidget(AppStrings.addresses, () {
          Navigator.pushNamed(context,AppRoutes.allAddressesRoute);
        }, Icons.location_city),
        profileButtonWidget(AppStrings.orders, () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const OrdersView()));
        }, Icons.motorcycle_sharp),
        profileButtonWidget(AppStrings.logOut, () {}, Icons.logout),

      ],
    );
  }

  Widget profileButtonWidget(
      String title, VoidCallback onTap, IconData iconData) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s4),
      margin: const EdgeInsets.all(AppSize.s4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        // border: Border.all(color: AppColors.primary),
      ),
      child: ListTile(
        leading: Icon(
          iconData,
          color: AppColors.primary,
        ),
        title: Text(
          title,
          style: getMediumTextStyle(),
        ),
        onTap: onTap,
        trailing: const Icon(Icons.arrow_back_ios,textDirection: TextDirection.rtl,size: AppSize.s18,),
      ),
    );
  }
}
