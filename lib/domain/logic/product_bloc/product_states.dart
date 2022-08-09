import '../../models/product.dart';

abstract class ProductStates{}

class ProductInitialState extends ProductStates{}

class GetAllProductCompletedState extends ProductStates {
  List<Product> products = [];
  GetAllProductCompletedState(this.products);
}

class GetAllProductLoadingState extends ProductStates {}

class GetAllProductFailedState extends ProductStates {
  String message;
  GetAllProductFailedState(this.message);
}
