import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_user/data/Network/firebase_paths.dart';

import '../../domain/models/product.dart';
import '../../domain/models/user.dart';

class AppServiceClient {
  final _db = FirebaseFirestore.instance;
  final _uid = FirebaseAuth.instance.currentUser?.uid ?? "9B71c79f6uYW6sLEcVBiQpjBEXD3";
  Future<List<dynamic>> getAllPopularProducts() async {
    final products = await _db.collection(AppFirebasePaths.products).get();
    return products.docs;
  }

  Future<List<dynamic>> getAllBanners() async {
    final products = await _db.collection(AppFirebasePaths.banners).get();
    return products.docs;
  }

  Future<dynamic> addToCart(String prodId, int quantity) async {
    await _db.collection(AppFirebasePaths.users).doc(_uid).set({
      "cart": {
        prodId: {
          "id": prodId,
          "quantity": quantity,
        }
      }
    }, SetOptions(merge: true));
  }

  Future<List<dynamic>>getAllCartProducts() async {
    List<Map<String, dynamic>> cartProducts = [];
    final firebaseUser =
        await _db.collection(AppFirebasePaths.users).doc(_uid).get();

    UserModel user = UserModel.fromFireStore(firebaseUser);
    if (user.cart?.values == null) {
      return [];
    } else {
      for (var data in user.cart!.values) {
        final prodId = data['id'];
        final product =
            await _db.collection(AppFirebasePaths.products).doc(prodId).get();

        final quantity = data['quantity'];
        Map<String, dynamic> cartData = {
          "product": product,
          "quantity": quantity,
        };
        cartProducts.add(cartData);
      }
    }
    return cartProducts;
  }
  Future<dynamic> deleteFromCart(String prodId) async {
    await _db.collection(AppFirebasePaths.users).doc(_uid).set({
      "cart": {
        prodId: FieldValue.delete(),
      }
    }, SetOptions(merge: true));
  }


  Future<void> updateProductInCartQuantity(
      String uid, String prodId, int quantity) async {
    await _db.collection(AppFirebasePaths.users).doc(uid).set({
      "cart": {
        prodId: {
          "id": prodId,
          "quantity": quantity,
        }
      }
    }, SetOptions(merge: true));
  }

  Future<void> setFavouriteProduct(String prodId) async {
    await _db.collection(AppFirebasePaths.users).doc(_uid).set({
      "favourite": FieldValue.arrayUnion([prodId])
    }, SetOptions(merge: true));
  }
  Future<List<dynamic>> getAllFavouriteProducts() async{
    final favouriteProducts = [];
    final  user = await _db.collection(AppFirebasePaths.users).doc(_uid).get();
    UserModel userModel = UserModel.fromFireStore(user);
    final favouriteProductsId = userModel.favourite;
    if(favouriteProductsId != null){
      for( var prodId in favouriteProductsId){
        final product =
        await _db.collection(AppFirebasePaths.products).doc(prodId).get();
        favouriteProducts.add(product);
      }
      return favouriteProducts;
    }else{
      return [];
    }

  }
  Future<void> deleteFavouriteProduct(String prodId) async {
    await _db.collection(AppFirebasePaths.users).doc(_uid).set({
      "favourite": FieldValue.arrayRemove([prodId])
    }, SetOptions(merge: true));
  }

}

