import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/favourite_bloc/favourite_cubit.dart';
import 'package:food_user/domain/logic/favourite_bloc/favourite_states.dart';
import 'package:food_user/presentation/resources/color_manager.dart';

import '../../../../app/constants.dart';
import '../../../../domain/logic/cart_bloc/cart_cubit.dart';
import '../../../resources/route_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../resources/widgets_manager.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  @override
  void initState() {
    super.initState();
    FavouriteCubit.get(context).getAllFavouriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<FavouriteCubit, FavouriteStates>(
        listener: (context, state) {
          if (state is GetAllFavouriteProductsFailedState) {
            getFlashBar(state.message, context);
          }
          if (state is GetAllFavouriteProductsLoadingState) {
            const CircularProgressIndicator();
          }
        },
        builder: (context, state) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top:AppSize.s20,left:AppSize.s20,right: AppSize.s20, ),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _topBarSection(),
                const SizedBox(
                  height: AppSize.s35,
                ),
                state is GetAllFavouriteProductsCompletedState
                    ? _favouriteProductsSection(state)
                    : const Center(child: CircularProgressIndicator(),),
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
          AppStrings.favourite,
          style: getBoldTextStyle(color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _favouriteProductsSection(
      GetAllFavouriteProductsCompletedState state) {
    final favProducts = state.favProducts;
    return favProducts.isNotEmpty ? Container(
      color: AppColors.backgroundColor,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: favProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppSize.s2.toInt(),
              childAspectRatio: 2 / 3.6,
              mainAxisSpacing: AppSize.s30,
              crossAxisSpacing: AppSize.s10),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.productDetailsRoute);
                },
                child: GetProductWidget(
                  () {
                    CartCubit.get(context).addToCart(
                        prodId: favProducts[index].id ?? AppConstants.empty,
                        quantity: 1);
                  },
                  isFavourite: true,
                  product: favProducts[index],

                ));
          }),
    ):const Text(AppStrings.noFavouriteProducts);
  }
}
