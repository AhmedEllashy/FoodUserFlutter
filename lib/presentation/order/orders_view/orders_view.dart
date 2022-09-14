import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/app/constants.dart';
import 'package:food_user/domain/logic/order_bloc/order_cubit.dart';
import 'package:food_user/domain/models/order.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/route_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/styles_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../resources/assets_manager.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int tabIndex = 0;
  List<Widget> tabs = [
    const Tab(
      text: AppStrings.active,
    ),
    const Tab(
      text: AppStrings.completed,
    ),
    const Tab(
      text: AppStrings.cancelled,
    ),
  ];
  @override
  void initState() {
    super.initState();
    OrderCubit.get(context).getOrders();
    _tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 0);
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
          padding: const EdgeInsets.all(AppSize.s12),
          child: ListView(
            children: [
              topBarSection(AppStrings.orders, context),
              const SizedBox(
                height: AppSize.s8,
              ),
              _tabBarSection(),
              const SizedBox(
                height: AppSize.s18,
              ),
              _ordersListSection(tabIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabBarSection() {
    return TabBar(
      tabs: tabs,
      controller: _tabController,
      indicatorColor: AppColors.primary,
      labelStyle: getMediumTextStyle(),
      onTap: (index) {
        setState(() {
          tabIndex = index;
        });
      },
    );
  }

  Widget _ordersListSection(int index) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is GetOrdersFailedState) {
          getFlashBar(state.message, context);
        }
      },
      builder: (context, state) {
        if (state is GetOrdersCompletedState) {
          final orders = state.orders;
          final processingOrders = orders
              .where((order) => order.orderStatus == "Processing")
              .toList();
          final completedOrders = orders
              .where((order) => order.orderStatus == "Completed")
              .toList();
          final cancelledOrders = orders
              .where((order) => order.orderStatus == "Cancelled")
              .toList();

          List<Order> checkIndex() {
            if (index == 0) {
              return processingOrders;
            } else if (index == 1) {
              return completedOrders;
            } else {
              return cancelledOrders;
            }
          }

          return checkIndex().isNotEmpty ? ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _orderWidget(checkIndex(), index);

              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: AppSize.s20,
                );
              },
              itemCount: processingOrders.length):const Center(child: Text(AppStrings.emptyOrders));
        } else if (state is GetOrdersLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text("No Orders"),
          );
        }
      },
    );
  }

  Widget _orderWidget(List<Order> orders, int index) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.orderDetailsViewRoute);
      },
      child: Container(
        padding: const EdgeInsets.all(AppSize.s12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              height: AppSize.s90,
              imageUrl: orders[index].products?[0].imageUrl ?? "",
              placeholder: (context, url) => Image.asset(AppAssets.imageIcon),
              errorWidget: (context, url, error) =>
                  Image.asset(AppAssets.imageIcon),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.s12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orders[index].products![0].name,
                      style: getBoldTextStyle(),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Text(
                      "${orders[index].products!.length} items",
                      style: getRegularTextStyle(),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${orders[index].total}${AppConstants.dollar}",
                          style: getBoldTextStyle(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: getOrderStatusColor(orders, index,
                                isBackground: true),
                            border: Border.fromBorderSide(
                              BorderSide(
                                  color: getOrderStatusColor(orders, index,
                                      isBorder: true)),
                            ),
                            borderRadius: BorderRadius.circular(AppSize.s6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${orders[index].orderStatus}",
                              style: getRegularTextStyle(
                                  fontSize: AppFontSizes.f14,
                                  color: getOrderStatusColor(orders, index,
                                      isText: true)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getOrderStatusColor(List<Order> orders, int index,
      {bool isBackground = false, bool isBorder = false, bool isText = false}) {
    if (orders[index].orderStatus == "Completed") {
      return isText ? AppColors.white : AppColors.green;
    } else if (orders[index].orderStatus == "Cancelled") {
      return isBackground
          ? Colors.transparent
          : isBorder
              ? AppColors.error
              : AppColors.error;
    } else {
      return isText ? AppColors.white : AppColors.primary;
    }
  }
}
