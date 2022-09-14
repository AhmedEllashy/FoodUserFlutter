part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}
class AddPaymentLoadingState extends PaymentState{}
class AddPaymentFailedState extends PaymentState{
  final String message;
  AddPaymentFailedState(this.message);
}
class AddPaymentCompletedState extends PaymentState{}