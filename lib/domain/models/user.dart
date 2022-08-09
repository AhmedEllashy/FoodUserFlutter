import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String  ?uid;
  String ?name;
  String ? email;
  String ? phoneNumber;
  String ?imageUrl;
  String ? status;
  Map<String, dynamic> ? cart;
  // String tokenId;
  // String defaultAddress;
  // List address;
  List<dynamic> ?favourite;
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
    this.favourite,
  });

  factory UserModel.fromFireStore( DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map<String,dynamic>; // DownCasting
    return UserModel(
      uid: data["uid"] ?? "",
      // name: snapshot['name'],
      email: data['email'] ?? "",
      phoneNumber: data['phoneNumber'] ?? "",
      imageUrl: data['photoUrl'] ?? "",
      status: data['status'] ?? "",
      cart: data['cart'] ?? {},
      favourite: data['favourite'] ?? [],

    );
  }
}
