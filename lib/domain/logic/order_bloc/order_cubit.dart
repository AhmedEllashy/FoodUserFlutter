import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/Repository/repository.dart';
import '../../models/cart.dart';
import '../../models/order.dart';
import '../../models/product.dart';
import '../../models/user.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final Repository _repository;
  OrderCubit(this._repository) : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of<OrderCubit>(context);

  Future<void> addOrder(List<Cart> products, String total, String transactionId,
      UserAddress deliverAddress) async{
    emit(AddOrderLoadingState());
    await _repository.addOrder(products, total, transactionId, deliverAddress).then(
        (_) {
      emit(AddOrderCompletedState());
    }, onError: (error) => emit(AddOrderFailedState(error.toString())));
  }

  void getOrders() {
    emit(GetOrdersLoadingState());
    _repository.getUserOrders().then((orders) {
      emit(GetOrdersCompletedState(orders));
    }, onError: (error) => emit(GetOrdersFailedState(error.toString())));
  }
}
