import 'package:flutter/material.dart';
import 'package:food_user/domain/logic/order_bloc/order_cubit.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    super.initState();
    OrderCubit.get(context).getOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

