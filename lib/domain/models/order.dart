import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_user/domain/models/user.dart';

class Order {

  String ?orderId;
  String ?orderStatus;
  UserAddress? userAddress;
  Timestamp ?orderTimestamp;
  List<OrderProduct> ?products;
  String ?transactionId;
  String ?total;


  Order({
    this.orderId,
    this.orderStatus,
    this.userAddress,
    this.orderTimestamp,
    this.products,
    this.transactionId,
    this.total,
  });

  factory Order.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Order(
      userAddress: UserAddress.formJson(data['deliveryAddressDetails']),
      orderId: data['orderId'],
      orderStatus: data['orderStatus'],
      orderTimestamp: data['orderTimestamp'],
      products: List<OrderProduct>.from(
        data['products'].map(
              (data) {
            return OrderProduct(
              id: data['id'],
              name: data['name'],
              category: data['category'],
              discount: data['discount'],
              price: data['price'],
              imageUrl: data['imageUrl'],
              quantity: data['quantity'],
              status : data["status"]
            );
          },
        ),
      ),
      transactionId: data['transactionId'],
      total: data['total'],

    );
  }
}




class OrderProduct {
  String name;
  String id;
  String category;
  String discount;
  String price;
  String imageUrl;
  int quantity;
  String status;

  OrderProduct({
    required this.name,
    required this.id,
    required this.category,
    required this.discount,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.status,
  });

  factory OrderProduct.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return OrderProduct(
      id: data['id'],
      name: data['name'],
      category: data['category'],
      discount: data['discount'],
      price: data['price'],
      imageUrl: data['imageUrl'],
      quantity: data['quantity'],
      status: data['status'],
    );
  }
}
