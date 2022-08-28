part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class AddOrderCompletedState extends OrderState{}
class AddOrderLoadingState extends OrderState{}
class AddOrderFailedState extends OrderState{
  final String message;
  AddOrderFailedState(this.message);
}
class GetOrdersCompletedState extends OrderState{
  final List<Order> orders;
  GetOrdersCompletedState(this.orders);
}
class GetOrdersLoadingState extends OrderState{}
class GetOrdersFailedState extends OrderState{
  final String message;
  GetOrdersFailedState(this.message);
}
