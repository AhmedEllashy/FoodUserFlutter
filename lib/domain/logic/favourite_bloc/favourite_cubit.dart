import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/favourite_bloc/favourite_state.dart';

import '../../../data/Repository/repository.dart';
import '../../models/product.dart';

class FavouriteCubit extends Cubit<FavouriteState>{
  final Repository _repository;
  FavouriteCubit(this._repository):super(FavouriteInitialState());

  static FavouriteCubit get(context) => BlocProvider.of<FavouriteCubit>(context);

  void setFavouriteProduct(String prodId){
    _repository.setFavouriteProduct(prodId);
  }
  void getAllFavouriteProducts(){
    emit(GetAllFavouriteProductsLoadingState());
    _repository.getAllFavouriteProducts().then((favProducts){
      emit(GetAllFavouriteProductsCompletedState(favProducts));
    },onError: (e){
      emit(GetAllFavouriteProductsFailedState(e.toString()));
    });
  }
  void deleteFavouriteProduct( String prodId){
    _repository.deleteFavouriteProduct(prodId);
  }
}