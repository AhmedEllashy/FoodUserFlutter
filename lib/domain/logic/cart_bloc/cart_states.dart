import '../../models/cart.dart';

abstract class CartStates{}
class CartInitialState extends CartStates{}

class AddToCartCompletedState extends CartStates{}
class AddToCartLoadingState extends CartStates{}
class AddToCartFailedState extends CartStates{
  String message;
  AddToCartFailedState(this.message);
}


class GetFromCartCompletedState extends CartStates{
  List<Cart> cartProducts = [];
  GetFromCartCompletedState(this.cartProducts);
}
class GetFromCartLoadingState extends CartStates{}
class GetFromCartFailedState extends CartStates{
  String message;
  GetFromCartFailedState(this.message);
}

class UpdateProductInCartQuantityCompletedState extends CartStates{}
class UpdateProductInCartQuantityLoadingState extends CartStates{}
class UpdateProductInCartQuantityFailedState extends CartStates{
  String message;
  UpdateProductInCartQuantityFailedState(this.message);
}


class DeleteFromCartCompletedState extends CartStates{}
class DeleteFromCartLoadingState extends CartStates{}
class DeleteFromCartFailedState extends CartStates{
  String message;
  DeleteFromCartFailedState(this.message);
}
