import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/app/constants.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_cubit.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_states.dart';
import 'package:food_user/presentation/check_out/check_out_view.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../../../domain/models/cart.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // String userCredential = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    CartCubit.get(context).getAllCartProducts(firstTime: true);
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) => SafeArea(
          child: Container(
            // margin: const EdgeInsets.all(AppSize.s10),
            padding: const EdgeInsets.all(AppSize.s20),
            child: Column(
              children: [
                _topBarSection(),
                const SizedBox(
                  height: AppSize.s30,
                ),
                state is GetFromCartCompletedState
                    ? _cartProductsSection(state)
                    : state is GetFromCartLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : state is GetFromCartFailedState
                            ? Text(state.message)
                            : const SizedBox(),
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
          AppStrings.cart,
          style: getBoldTextStyle(color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _cartProductsSection(GetFromCartCompletedState state) {
    final cartProducts = state.cartProducts;
    return cartProducts != []
        ? Expanded(
            child: ListView.separated(
              itemCount: cartProducts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(UniqueKey().toString()),
                  direction: DismissDirection.horizontal,
                  onDismissed: (dismissDirection) {
                    CartCubit.get(context)
                        .deleteFromCart(cartProducts[index].product?.id ?? "");
                  },
                  background: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppSize.s30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppSize.s14),
                          child: Icon(
                            Icons.delete,
                            color: AppColors.white,
                          ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CachedNetworkImage(
                              height: AppSize.s80,
                              imageUrl:
                                  cartProducts[index].product?.imageUrl ?? "",
                              placeholder: (context, url) =>
                                  Image.asset(AppAssets.imageIcon),
                              errorWidget: (context, url, error) =>
                                  Image.asset(AppAssets.imageIcon),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSize.s4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cartProducts[index].product?.name ?? "",
                                    style: getBoldTextStyle(
                                        fontSize: AppFontSizes.f18),
                                  ),
                                  const SizedBox(
                                    height: AppSize.s20,
                                  ),
                                  Text(
                                    '${AppConstants.dollar}${cartProducts[index].product?.price ?? ""}',
                                    style: getBoldTextStyle(
                                        fontSize: AppFontSizes.f18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSize.s6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _counterRow("9B71c79f6uYW6sLEcVBiQpjBEXD3",
                                  state.cartProducts[index]),
                              const SizedBox(
                                height: AppSize.s16,
                              ),
                              Text(
                                '${AppConstants.dollar}${CartCubit.get(context).calculateQuantityPrice(
                                  cartProducts[index].product!.price!,
                                  cartProducts[index].quantity!,
                                )}',
                                style: getBoldTextStyle(
                                    fontSize: AppFontSizes.f18),
                              ),
                            ],
                          ),
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
          )
        : const Center(
            child: Text("Cart is Empty"),
          );
  }

  Widget _bottomFeesSection() {
    return Column(
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
                '${AppConstants.dollar}${CartCubit.get(context).subTotal}',
                style: getRegularTextStyle(
                    color: AppColors.grey,
                    fontSize: AppFontSizes.f16,
                    fontWeight: AppFontWeights.w4,
                    letterSpacing: 0.0),
              ),
            ],
          ),
        ),
        _dashLineWidget(),
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
        _dashLineWidget(),
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
                '${AppConstants.dollar}${CartCubit.get(context).getTotal()}',
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
  }

  Widget _bottomButton() {
    return AppButton(AppStrings.reviewPayment, () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => CheckOutView(
                    subTotal: CartCubit.get(context).subTotal.toString(),
                total:CartCubit.get(context).getTotal() ,
                  )));
    });
  }

  Widget _counterRow(String uid, Cart cartProducts) {
    int counter = cartProducts.quantity!;
    String price = cartProducts.product?.price ?? "0";
    String prodId = cartProducts.product?.id ?? "";

    double height = AppSize.s30;
    double width = AppSize.s30;

    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        if (state is UpdateProductInCartQuantityFailedState) {
          getFlashBar(state.message, context);
        }
      },
      builder: (context, state) => Row(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: const Border.fromBorderSide(
                  const BorderSide(color: AppColors.black)),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  if (counter != 1) {
                    counter--;
                    CartCubit.get(context).updateProductInCartQuantity(
                        uid: uid, prodId: prodId, quantity: counter);
                    CartCubit.get(context)
                        .getSubTotal(price, 1, operation: "minus");
                  }
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
                  CartCubit.get(context).updateProductInCartQuantity(
                      uid: uid, prodId: prodId, quantity: counter);
                  CartCubit.get(context).getSubTotal(price, 1);
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

  Widget _dashLineWidget() {
    return const DottedLine(
      dashColor: AppColors.grey,
    );
  }
}
