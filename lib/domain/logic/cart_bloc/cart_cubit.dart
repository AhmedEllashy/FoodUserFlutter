import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_state.dart';

import '../../../data/Repository/repository.dart';
import '../../models/cart.dart';

class CartCubit extends Cubit<CartState> {
  final Repository _repository;

  List<Cart> cartProducts = [];
  double subTotal = 0.0;
  double delivery = 0.0;
  CartCubit(this._repository) : super(CartInitialState());
  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);

  void addToCart({required String prodId, required int quantity}) {
    emit(AddToCartLoadingState());
    _repository.addToCart(prodId, quantity).then((_) {
      emit(AddToCartCompletedState());
    }, onError: (e) {
      emit(AddToCartFailedState(e.toString()));
    });
  }

  void updateProductInCartQuantity(
      {required String prodId, required int quantity}) {
    emit(UpdateProductInCartQuantityLoadingState());
    _repository.updateProductInCartQuantity(prodId, quantity).then((_) {
      emit(UpdateProductInCartQuantityCompletedState());
      getAllCartProducts();
    }, onError: (e) {
      emit(UpdateProductInCartQuantityFailedState(e.toString()));
    });
  }

  List<Cart> getAllCartProducts() {
    emit(GetFromCartLoadingState());
    _repository.getAllCartProducts().then((cartProd) {
      subTotal = 0.0;
      for (var prod in cartProd) {
        getSubTotal(prod.product?.price ?? "0", prod.quantity ?? 0);
      }
      emit(GetFromCartCompletedState(cartProd));
      cartProducts = cartProd;
    }, onError: (e) {
      emit(GetFromCartFailedState(e.toString()));
    });
    return cartProducts;
  }

  void deleteFromCart(String prodId) {
    emit(DeleteFromCartLoadingState());
    _repository.deleteFromCart(prodId).then((_) {
      emit(DeleteFromCartCompletedState());
      getAllCartProducts();
    }, onError: (e) => emit(DeleteFromCartFailedState(e.toString())));
  }

  String calculateQuantityPrice(String price, int quantity) {
    int result = int.parse(price) * quantity;
    return result.toString();
  }

  String getSubTotal(String price, int quantity, {String operation = "add"}) {
    if (operation == "add") {
      subTotal += double.parse(calculateQuantityPrice(price, quantity));
    } else {
      subTotal -= double.parse(calculateQuantityPrice(price, quantity));
    }
    return subTotal.toString();
  }

  String getTotal() {
    double result = subTotal + delivery;
    return result.toString();
  }
}
