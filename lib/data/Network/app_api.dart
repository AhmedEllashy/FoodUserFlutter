import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_user/data/Network/firebase_paths.dart';

import '../../domain/models/cart.dart';
import '../../domain/models/product.dart';
import '../../domain/models/user.dart';
import 'package:uuid/uuid.dart';

class AppServiceClient {
  final _db = FirebaseFirestore.instance;
  final _uid =
      FirebaseAuth.instance.currentUser?.uid ?? "uIzka0jiZHPLm9THiDvwqLmi2uf2";
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

  Future<List<dynamic>> getAllCartProducts() async {
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

  Future<List<dynamic>> getAllFavouriteProducts() async {
    final favouriteProducts = [];
    final user = await _db.collection(AppFirebasePaths.users).doc(_uid).get();
    UserModel userModel = UserModel.fromFireStore(user);
    final favouriteProductsId = userModel.favourite;
    if (favouriteProductsId != null) {
      for (var prodId in favouriteProductsId) {
        final product =
            await _db.collection(AppFirebasePaths.products).doc(prodId).get();
        favouriteProducts.add(product);
      }
      return favouriteProducts;
    } else {
      return [];
    }
  }

  Future<void> deleteFavouriteProduct(String prodId) async {
    await _db.collection(AppFirebasePaths.users).doc(_uid).set({
      "favourite": FieldValue.arrayRemove([prodId])
    }, SetOptions(merge: true));
  }

  Future<void> addOrder(
      String orderId, List<Cart> products, String total) async {
    //todo complete func
    await _db.collection(AppFirebasePaths.users).doc(_uid).set({
      "orders": {
        orderId: {
          "products": products,
          "total": total,
        }
      }
    });
    // await _db.collection(collectionPath)
  }

  Future<void> addAddress(
      String name,
      String addressName,
      String phoneNumber,
      String country,
      String city,
      String detailsAboutAddress,
      double lat,
      double long) async {
    await _db.collection(AppFirebasePaths.users).doc(_uid).set({
      "addresses": FieldValue.arrayUnion([
        {
          "name": name,
          "addressName": addressName,
          "phoneNumber": phoneNumber,
          "country": country,
          "city": city,
          "detailsAboutAddress": detailsAboutAddress,
          "lat": lat,
          "long": long,
        }
      ])
    }, SetOptions(merge: true));
  }

  Future<List<UserAddress>> getAllAddresses() async {
    List<UserAddress> addressesList = [];
    final firebaseUser =
        await _db.collection(AppFirebasePaths.users).doc(_uid).get();
    UserModel user = UserModel.fromFireStore(firebaseUser);
    final userAddresses = user.addresses;
    if (userAddresses != null) {
      if (userAddresses.isNotEmpty) {
        for (var item in userAddresses) {
          final address = UserAddress.formJson(item);
          addressesList.add(address);
        }
      }
    }
    return addressesList;
  }

  Future<void> editAddress(List<UserAddress> addresses) async {
    final firebaseUser =
        await _db.collection(AppFirebasePaths.users).doc(_uid).get();
    UserModel user = UserModel.fromFireStore(firebaseUser);
    if (user.addresses != null) {
      if (user.addresses!.isNotEmpty) {
        await _db.collection(AppFirebasePaths.users).doc(_uid).set({
          "addresses": FieldValue.delete(),
        },SetOptions(merge: true));
        await _db.collection(AppFirebasePaths.users).doc(_uid).set({
          "addresses": FieldValue.arrayUnion(
              [for (int i = 0; i < addresses.length; i++) {
                  "name": addresses[i].name,
                  "addressName": addresses[i].addressName,
                  "phoneNumber": addresses[i].phoneNumber,
                  "country": addresses[i].country,
                  "city": addresses[i].city,
                  "detailsAboutAddress": addresses[i].detailsAboutAddress,
                  "lat": addresses[i].lat,
                  "long": addresses[i].long,

              }]),
        },SetOptions(merge: true));
      }
    }
  }

  Future<String> getDefaultAddress() async {
    final firebaseUser =
        await _db.collection(AppFirebasePaths.users).doc(_uid).get();
    UserModel user = UserModel.fromFireStore(firebaseUser);
    final defaultAddress = user.defaultAddress;
    return defaultAddress!;
  }

  Future<void> setDefaultAddress(String defaultAddress) async {
    await _db.collection(AppFirebasePaths.users).doc(_uid).set({
      "defaultAddress": defaultAddress,
    }, SetOptions(merge: true));
  }
}
