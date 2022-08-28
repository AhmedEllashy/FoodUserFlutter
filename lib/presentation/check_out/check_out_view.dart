import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_user/data/Network/payment_api.dart';
import 'package:food_user/domain/logic/address_bloc/address_cubit.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_cubit.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_states.dart';
import 'package:food_user/domain/logic/order_bloc/order_cubit.dart';
import 'package:food_user/domain/models/cart.dart';
import 'package:food_user/presentation/address/add_address/add_address_view.dart';
import 'package:food_user/presentation/resources/route_manager.dart';

import '../../app/constants.dart';
import '../../domain/logic/address_bloc/address_states.dart';
import '../../domain/models/product.dart';
import '../../domain/models/user.dart';
import '../address/edit_address/edit_address_view.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';
import '../resources/widgets_manager.dart';

class CheckOutView extends StatefulWidget {
  List<Cart>? cartProducts;
  String? subTotal;
  String? delivery;
  String? total;

  CheckOutView({
    Key? key,
    this.cartProducts,
    this.subTotal,
    this.delivery,
    this.total,
  }) : super(key: key);

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  final TextEditingController _couponTextEditingController =
      TextEditingController();
  List<UserAddress> addresses = [];
  int? defaultAddressIndex;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      AddressCubit.get(context).getAllAddresses();
      defaultAddressIndex =
          int.parse(await AddressCubit.get(context).getDefaultAddress());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocConsumer<AddressCubit, AddressStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetAllAddressesCompletedState) {
            addresses = state.addresses;
            return Padding(
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
                        height: AppSize.s20,
                      ),
                      _addressWidget(),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      _couponSection(),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      _bottomFeesSection(),
                      _bottomButton(),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is GetAllAddressesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
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

  Widget _addressWidget() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: AppSize.s70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
          border: Border.all(color: Colors.transparent),
        ),
        child: Center(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.location_on_rounded,
                color: AppColors.white,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(AppSize.s3),
              child: Text(
                addresses.isNotEmpty
                    ? addresses[defaultAddressIndex??0].addressName
                    : AppStrings.addDeliveryAddress,
                style: getMediumTextStyle(),
              ),
            ),
            subtitle: defaultAddressIndex != null
                ? Padding(
                    padding: const EdgeInsets.all(AppSize.s4),
                    child: Text(
                      addresses[defaultAddressIndex!].detailsAboutAddress,
                      style: getRegularTextStyle(),
                    ),
                  )
                : null,
            trailing: IconButton(
              icon: Icon(
                addresses.isNotEmpty
                    ? Icons.edit_location_alt_outlined
                    : Icons.add,
                color: AppColors.primary,
              ),
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => addresses.isNotEmpty
                                ? EditAddressView(
                                    addresses[defaultAddressIndex!],
                                    defaultAddressIndex!,
                                  )
                                : AddAddressView(addresses: addresses)))
                    .then((value) => setState(() async {
                          AddressCubit.get(context).getAllAddresses();
                          defaultAddressIndex = int.parse(
                              await AddressCubit.get(context)
                                  .getDefaultAddress());
                        }));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _couponSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 2, child: _couponTextFormField()),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: AppSize.s10),
          child: AppButton(
            AppStrings.apply,
            () {},
            height: AppSize.s60,
          ),
        )),
      ],
    );
  }

  Widget _bottomFeesSection() {
    // return BlocBuilder<CartCubit,CartStates>(
    //   builder:(context,state)=>
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

    return BlocConsumer<OrderCubit, OrderState>(listener: (context, state) {
      if (state is AddOrderFailedState) {
        getFlashBar(state.message, context);
      }
    }, builder: (context, state) {
      return state is AddOrderLoadingState
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AppButton(AppStrings.checkOut, () async {
              if (addresses.isEmpty || defaultAddressIndex == null) {
                getFlashBar(AppStrings.addDeliveryAddress, context);
              }

              PaymentApi().initPayment(email: "email@yahoo.com", amount: 100.0, context: context).then((_){
                OrderCubit.get(context).addOrder(
                    widget.cartProducts ?? [],
                    widget.total ?? "0.0",
                    "test",
                    addresses[defaultAddressIndex!]);
                state is AddOrderCompletedState
                    ? Navigator.pushNamed(context, AppRoutes.successRoute)
                    : null;
              },onError: (e){
                getFlashBar(e.toString(), context);
              });


            });
    });
  }

  Widget _couponTextFormField() {
    return TextFormField(
      controller: _couponTextEditingController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.card_giftcard,
          size: AppSize.s20,
        ),
        hintText: AppStrings.couponCode,
        hintStyle: getTextStyle(AppColors.mainFontColor, AppFontSizes.f14,
            AppFontWeights.w3, AppSize.s1_5, AppSize.s1_5),
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
          borderSide:
              const BorderSide(width: AppSize.s2, color: AppColors.error),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: AppSize.s2, color: AppColors.error),
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }
}
