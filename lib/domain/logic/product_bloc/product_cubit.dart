import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/domain/logic/product_bloc/product_state.dart';

import '../../../data/Repository/repository.dart';
import '../../models/product.dart';

class ProductCubit extends Cubit<ProductState> {
  final Repository _repository;
  List<Product> products = [];
  ProductCubit(this._repository) : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);

  List<Product> getAllProducts()  {
    emit(GetAllProductLoadingState());

    _repository.getAllProducts().then((products){
      emit(GetAllProductCompletedState(products));
      this.products = products;
    }).catchError((e){
      emit(GetAllProductFailedState(e.toString()));
    });

    return products;

  }
}
