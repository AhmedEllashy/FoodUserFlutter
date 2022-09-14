import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_user/data/Network/firebase_paths.dart';
import 'package:food_user/domain/models/order.dart';

import '../../domain/models/cart.dart';
import '../../domain/models/product.dart';
import '../../domain/models/user.dart';
import 'package:uuid/uuid.dart';

class AppServiceClient {
  final _db = FirebaseFirestore.instance;
  final _uid =
      FirebaseAuth.instance.currentUser?.uid ?? "uIzka0jiZHPLm9THiDvwqLmi2uf2";
  Future<List<dynamic>> getAllPopularProducts() async {
    final products = await _db.collection(FirestoreConstants.products).get();
    return products.docs;
  }

  Future<List<dynamic>> getAllBanners() async {
    final products = await _db.collection(FirestoreConstants.banners).get();
    return products.docs;
  }

  Future<dynamic> addToCart(String prodId, int quantity) async {
    await _db.collection(FirestoreConstants.users).doc(_uid).set({
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
        await _db.collection(FirestoreConstants.users).doc(_uid).get();

    UserDataModel user = UserDataModel.fromFireStore(firebaseUser);
    if (user.cart?.values == null) {
      return [];
    } else {
      for (var data in user.cart!.values) {
        final prodId = data['id'];
        final product =
            await _db.collection(FirestoreConstants.products).doc(prodId).get();

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
    await _db.collection(FirestoreConstants.users).doc(_uid).set({
      "cart": {
        prodId: FieldValue.delete(),
      }
    }, SetOptions(merge: true));
  }

  Future<void> updateProductInCartQuantity(String prodId, int quantity) async {
    await _db.collection(FirestoreConstants.users).doc(_uid).set({
      "cart": {
        prodId: {
          "id": prodId,
          "quantity": quantity,
        }
      }
    }, SetOptions(merge: true));
  }

  Future<void> setFavouriteProduct(String prodId) async {
    await _db.collection(FirestoreConstants.users).doc(_uid).set({
      "favourite": FieldValue.arrayUnion([prodId])
    }, SetOptions(merge: true));
  }

  Future<List<dynamic>> getAllFavouriteProducts() async {
    final favouriteProducts = [];
    final user = await _db.collection(FirestoreConstants.users).doc(_uid).get();
    UserDataModel userModel = UserDataModel.fromFireStore(user);
    final favouriteProductsId = userModel.favourite;
    if (favouriteProductsId != null) {
      for (var prodId in favouriteProductsId) {
        final product =
            await _db.collection(FirestoreConstants.products).doc(prodId).get();
        favouriteProducts.add(product);
      }
      return favouriteProducts;
    } else {
      return [];
    }
  }

  Future<void> deleteFavouriteProduct(String prodId) async {
    await _db.collection(FirestoreConstants.users).doc(_uid).set({
      "favourite": FieldValue.arrayRemove([prodId])
    }, SetOptions(merge: true));
  }

  Future<void> addOrder(List<Cart> products, String total, String transactionId,
      UserAddress deliverAddress) async {
    String orderId = const Uuid().v4();
    await _db.collection(FirestoreConstants.users).doc(_uid).set({
      "orders": FieldValue.arrayUnion([orderId]),
    }, SetOptions(merge: true));
    await _db.collection(FirestoreConstants.orders).doc(orderId).set({
      "orderId": orderId,
      "orderStatus": "Processing",
      "orderTimeStamp": DateTime.now(),
      "transactionId": "",
      "total": total,
      "deliveryAddressDetails": {
        "name": deliverAddress.name,
        "addressName": deliverAddress.addressName,
        "phoneNumber": deliverAddress.phoneNumber,
        "country": deliverAddress.country,
        "city": deliverAddress.city,
        "detailsAboutAddress": deliverAddress.detailsAboutAddress,
        "lat": deliverAddress.lat,
        "long": deliverAddress.long,
        "uid": _uid,
      },
    }, SetOptions(merge: true));

    for (var item in products) {
      await _db.collection(FirestoreConstants.orders).doc(orderId).set({
        "products": FieldValue.arrayUnion([
          {
            "id": item.product?.id ?? "",
            "name": item.product?.name ?? "",
            "category": item.product?.category ?? "",
            "price": item.product?.price ?? "",
            "discount": item.product?.discount ?? "",
            "status": item.product?.status ?? "",
            "quantity": item.quantity ?? "",
            "imageUrl": item.product?.imageUrl ?? "",
          }
        ])
      }, SetOptions(merge: true));
      await _db.collection(FirestoreConstants.users).doc(_uid).set({
        "cart": {},
      }, SetOptions(merge: true));
    }
  }

  Future<List<Order>> getUserOrders() async {
    List<Order> ordersList = [];
    final firebaseUser =
        await _db.collection(FirestoreConstants.users).doc(_uid).get();

    UserDataModel user = UserDataModel.fromFireStore(firebaseUser);
    final userOrders = user.orders;
    if (userOrders != null) {
      for (var orderId in userOrders.toList()) {
        final jsonOrder =
            await _db.collection(FirestoreConstants.orders).doc(orderId).get();
        final order = Order.fromFireStore(jsonOrder);
        ordersList.add(order);
      }
    }
    return ordersList;
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
    await _db.collection(FirestoreConstants.users).doc(_uid).set({
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
        await _db.collection(FirestoreConstants.users).doc(_uid).get();

    UserDataModel user = UserDataModel.fromFireStore(firebaseUser);
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
        await _db.collection(FirestoreConstants.users).doc(_uid).get();
    UserDataModel user = UserDataModel.fromFireStore(firebaseUser);
    if (user.addresses != null) {
      if (user.addresses!.isNotEmpty) {
        await _db.collection(FirestoreConstants.users).doc(_uid).set({
          "addresses": FieldValue.delete(),
        }, SetOptions(merge: true));
        await _db.collection(FirestoreConstants.users).doc(_uid).set({
          "addresses": FieldValue.arrayUnion([
            for (int i = 0; i < addresses.length; i++)
              {
                "name": addresses[i].name,
                "addressName": addresses[i].addressName,
                "phoneNumber": addresses[i].phoneNumber,
                "country": addresses[i].country,
                "city": addresses[i].city,
                "detailsAboutAddress": addresses[i].detailsAboutAddress,
                "lat": addresses[i].lat,
                "long": addresses[i].long,
              }
          ]),
        }, SetOptions(merge: true));
      }
    }
  }

  Future<String> getDefaultAddress() async {
    final firebaseUser =
        await _db.collection(FirestoreConstants.users).doc(_uid).get();
    UserDataModel user = UserDataModel.fromFireStore(firebaseUser);
    final defaultAddress = user.defaultAddress;
    return defaultAddress!;
  }

  Future<void> setDefaultAddress(String defaultAddress) async {
    await _db.collection(FirestoreConstants.users).doc(_uid).set({
      "defaultAddress": defaultAddress,
    }, SetOptions(merge: true));
  }

  Future<dynamic> getUserData() async {
    final firebaseUser =
        await _db.collection(FirestoreConstants.users).doc(_uid).get();
    return firebaseUser;
  }

  Future<List<dynamic>> getUserNotifications() async {
    final userNotifications = await _db
        .collection(FirestoreConstants.users)
        .doc(_uid)
        .collection(FirestoreConstants.notification)
        .get();
    return userNotifications.docs;
  }

  Stream<QuerySnapshot> getChatMessages() {
    return _db
        .collection(FirestoreConstants.usersMessages)
        .doc(_uid)
        .collection(FirestoreConstants.chat)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> sendMessage(String messageBody) async {
    final DocumentSnapshot messageCollectionUser =
        await _db.collection(FirestoreConstants.usersMessages).doc(_uid).get();
    if (messageCollectionUser.exists) {
      await _db
          .collection(FirestoreConstants.usersMessages)
          .doc(_uid)
          .collection(FirestoreConstants.chat)
          .add({
        "senderId": _uid,
        "receiverId": "",
        "messageBody": messageBody,
        "timestamp": DateTime.now(),
      });
      await _db.collection(FirestoreConstants.adminMessages).add({
        "senderId": _uid,
        "receiverId": "",
        "messageBody": messageBody,
        "timestamp": DateTime.now(),
      });
    } else {
      final firebaseUser =
          await _db.collection(FirestoreConstants.users).doc(_uid).get();
      UserDataModel user = UserDataModel.fromFireStore(firebaseUser);
      await _db.collection(FirestoreConstants.usersMessages).doc(_uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': user.name,
        'photoUrl': user.imageUrl,
      });
      await _db
          .collection(FirestoreConstants.usersMessages)
          .doc(_uid)
          .collection(FirestoreConstants.chat)
          .add({
        "senderId": _uid,
        "receiverId": "",
        "messageBody": messageBody,
        "timestamp": DateTime.now(),
      });
      await _db.collection(FirestoreConstants.adminMessages).add({
        "senderId": _uid,
        "receiverId": "",
        "messageBody": messageBody,
        "timestamp": DateTime.now(),
      });
    }
  }
}
