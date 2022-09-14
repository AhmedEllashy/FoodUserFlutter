import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String? uid;
  String? name;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  String? status;
  Map<String, dynamic>? cart;
  // String tokenId;
  String ?defaultAddress;
  List<dynamic>? addresses;
  List<dynamic>? favourite;
  List<dynamic>? orders;

  // String loggedInVia;
  // bool isBlocked;

  UserDataModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.imageUrl,
    this.status,
    this.cart,
    this.defaultAddress,
    this.addresses,
    this.favourite,
    this.orders,

  });

  factory UserDataModel.fromFireStore(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map<String, dynamic>; // DownCasting
    return UserDataModel(
      uid: data["uid"] ?? "",
      name: snapshot['name'] ?? "",
      email: data['email'] ?? "",
      phoneNumber: data['phoneNumber'] ?? "",
      imageUrl: data['photoUrl'] ?? "",
      status: data['status'] ?? "",
      cart: data['cart'] ?? {},
      defaultAddress: data['defaultAddress']??"",
      favourite: data['favourite'] ?? [],
      addresses: data['addresses'] ?? [],
      orders: data["orders"] ?? [],
    );
  }
}

class UserAddress {
  String name;
  String phoneNumber;
  String addressName;
  String city;
  String country;
  String detailsAboutAddress;
  double lat;
  double long;

  UserAddress({
    required this.name,
    required this.phoneNumber,
    required this.addressName,
    required this.city,
    required this.country,
    required this.detailsAboutAddress,
    required this.lat,
    required this.long,
  });

  factory UserAddress.formJson(Map<String, dynamic> data) {
    return UserAddress(
      name: data["name"],
      phoneNumber: data["phoneNumber"],
      addressName: data["addressName"],
      city: data["city"],
      country: data["country"],
      detailsAboutAddress: data["detailsAboutAddress"],
      lat: data["lat"],
      long: data['long'],
    );
  }
}


