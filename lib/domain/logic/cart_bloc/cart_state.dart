import '../../models/cart.dart';

abstract class CartState{}
class CartInitialState extends CartState{}

class AddToCartCompletedState extends CartState{}
class AddToCartLoadingState extends CartState{}
class AddToCartFailedState extends CartState{
  String message;
  AddToCartFailedState(this.message);
}


class GetFromCartCompletedState extends CartState{
  List<Cart> cartProducts = [];
  GetFromCartCompletedState(this.cartProducts);
}
class GetFromCartLoadingState extends CartState{}
class GetFromCartFailedState extends CartState{
  String message;
  GetFromCartFailedState(this.message);
}

class UpdateProductInCartQuantityCompletedState extends CartState{}
class UpdateProductInCartQuantityLoadingState extends CartState{}
class UpdateProductInCartQuantityFailedState extends CartState{
  String message;
  UpdateProductInCartQuantityFailedState(this.message);
}


class DeleteFromCartCompletedState extends CartState{}
class DeleteFromCartLoadingState extends CartState{}
class DeleteFromCartFailedState extends CartState{
  String message;
  DeleteFromCartFailedState(this.message);
}
