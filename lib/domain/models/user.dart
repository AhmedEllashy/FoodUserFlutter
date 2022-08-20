import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
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
  // String loggedInVia;
  // bool isBlocked;

  UserModel({
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

  });

  factory UserModel.fromFireStore(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map<String, dynamic>; // DownCasting
    return UserModel(
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
