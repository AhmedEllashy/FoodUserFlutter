import '../../models/product.dart';

abstract class ProductState{}

class ProductInitialState extends ProductState{}

class GetAllProductCompletedState extends ProductState {
  List<Product> products = [];
  GetAllProductCompletedState(this.products);
}

class GetAllProductLoadingState extends ProductState {}

class GetAllProductFailedState extends ProductState {
  String message;
  GetAllProductFailedState(this.message);
}
