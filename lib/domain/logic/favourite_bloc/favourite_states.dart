
import 'package:food_user/domain/logic/cart_bloc/cart_states.dart';
import 'package:food_user/domain/models/product.dart';

abstract class FavouriteStates{}

class FavouriteInitialState extends FavouriteStates{}
class AddToFavouriteCompletedState extends FavouriteStates{}
class AddToFavouriteLoadingState extends FavouriteStates{}
class AddToFavouriteFailedState extends FavouriteStates{
  String message;
  AddToFavouriteFailedState(this.message);
}
class GetAllFavouriteProductsCompletedState extends FavouriteStates{
  List<Product> favProducts = [];
  GetAllFavouriteProductsCompletedState(this.favProducts);
}
class GetAllFavouriteProductsLoadingState extends FavouriteStates{}
class GetAllFavouriteProductsFailedState extends FavouriteStates{
  String message;
  GetAllFavouriteProductsFailedState(this.message);
}

class DeleteFromFavouriteCompletedState extends CartStates{}
class DeleteFromFavouriteLoadingState extends CartStates{}
class DeleteFromFavouriteFailedState extends CartStates{
  String message;
  DeleteFromFavouriteFailedState(this.message);
}
