import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_user/domain/models/product.dart';

class Cart {
  Product ?product;
  int ? quantity;

  Cart({
    this.product,
    this.quantity,
  });

   factory Cart.fromFireStore(dynamic  snapshot, int quantity) {
      return Cart(
          product : Product.fromJson(snapshot),
          quantity : quantity,

      );

  }
}