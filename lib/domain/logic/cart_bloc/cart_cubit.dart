import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/cart_bloc/cart_states.dart';

import '../../../data/Repository/repository.dart';
import '../../models/cart.dart';

class CartCubit extends Cubit<CartStates> {
  final Repository _repository;

  List<Cart> cartProducts = [];
  int subTotal = 0;
  int delivery = 0;
  CartCubit(this._repository) : super(CartInitialState());
  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);

  void addToCart(
      { required String prodId, required int quantity}) {
    emit(AddToCartLoadingState());
    _repository.addToCart(prodId, quantity).then((_) {
      emit(AddToCartCompletedState());
    }, onError: (e) {
      emit(AddToCartFailedState(e.toString()));
    });
  }

  void updateProductInCartQuantity(
      { required String prodId, required int quantity}) {
    emit(UpdateProductInCartQuantityLoadingState());
    _repository.updateProductInCartQuantity(prodId, quantity).then((_) {
      emit(UpdateProductInCartQuantityCompletedState());
      getAllCartProducts();
    }, onError: (e) {
      emit(UpdateProductInCartQuantityFailedState(e.toString()));
    });
  }

  List<Cart> getAllCartProducts({bool firstTime = false}) {
    emit(GetFromCartLoadingState());
    _repository.getAllCartProducts().then((cartProd) {
       for (var prod in cartProd) {
         firstTime ?  getSubTotal(prod.product?.price ?? "0", prod.quantity ?? 0) : null;
      }
      emit(GetFromCartCompletedState(cartProd));
      cartProducts = cartProd;
    }, onError: (e) {
      emit(GetFromCartFailedState(e.toString()));
    });
    return cartProducts;
  }
  void deleteFromCart( String prodId){
    _repository.deleteFromCart(prodId);
  }
  String calculateQuantityPrice(String price, int quantity) {
    int result = int.parse(price) * quantity;
    return result.toString();
  }

  String getSubTotal(String price, int quantity,
      {String operation = "add"}) {
    if (operation == "add") {
      subTotal += int.parse(calculateQuantityPrice(price, quantity));
    } else {
      subTotal -= int.parse(calculateQuantityPrice(price, quantity));
    }
    return subTotal.toString();
  }
  String getTotal() {
    int result = subTotal + delivery;
    return result.toString();
  }
}
