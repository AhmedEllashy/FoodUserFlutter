
import 'package:food_user/domain/logic/cart_bloc/cart_state.dart';
import 'package:food_user/domain/models/product.dart';

abstract class FavouriteState{}

class FavouriteInitialState extends FavouriteState{}
class AddToFavouriteCompletedState extends FavouriteState{}
class AddToFavouriteLoadingState extends FavouriteState{}
class AddToFavouriteFailedState extends FavouriteState{
  String message;
  AddToFavouriteFailedState(this.message);
}
class GetAllFavouriteProductsCompletedState extends FavouriteState{
  List<Product> favProducts = [];
  GetAllFavouriteProductsCompletedState(this.favProducts);
}
class GetAllFavouriteProductsLoadingState extends FavouriteState{}
class GetAllFavouriteProductsFailedState extends FavouriteState{
  String message;
  GetAllFavouriteProductsFailedState(this.message);
}

class DeleteFromFavouriteCompletedState extends CartState{}
class DeleteFromFavouriteLoadingState extends CartState{}
class DeleteFromFavouriteFailedState extends CartState{
  String message;
  DeleteFromFavouriteFailedState(this.message);
}
