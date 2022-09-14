import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/Network/payment_api.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentApi _paymentApi;

  PaymentCubit(this._paymentApi) : super(PaymentInitial());
  static PaymentCubit get(context)=> BlocProvider.of<PaymentCubit>(context);

  initPayment({ required double amount, required BuildContext context}) {
    emit(AddPaymentLoadingState());
    _paymentApi.initPayment(amount: amount, context: context).then((_) =>
        emit(AddPaymentCompletedState()),
        onError: (e) => emit(AddPaymentFailedState(e.toString())));
  }
}
