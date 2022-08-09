import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
   String? id;
  String ? name;
  String ?category;
  String ?price;
  String ?discount;
  String ?status;
   int ?amount;
   String ?imageUrl;
   String ?deliveryTime;
   String ?description;



   Product({this.id,this.name,this.category,this.price,this.discount,this.status,
     this.amount,this.imageUrl,this.deliveryTime,this.description});

  factory Product.fromFiresStore(DocumentSnapshot snapshot){

    return Product(
    id : snapshot['id'],
    name : snapshot['name'],
    category : snapshot['category'],
    price : snapshot['price'],
    discount : snapshot['discount'],
    status : snapshot['status'],
    amount : snapshot['amount'],
    imageUrl : snapshot['imageUrl'],
    deliveryTime : snapshot['deliveryTime'],
    description : snapshot['description'],
    );
  }
   factory Product.fromJson(DocumentSnapshot snapshot){
     Map data = snapshot.data() as Map<String, dynamic>;
     return Product(
       id : data['id'],
       name : data['name'],
       category : data['category'],
       price : data['price'],
       discount : data['discount'],
       status : data['status'],
       amount : data['amount'],
       imageUrl : data['imageUrl'],
       deliveryTime : data['deliveryTime'],
       description : data['description'],
     );
   }
}