import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel{
  String ? id;
  String ? imageUrl;
  BannerModel(this.id,this.imageUrl);

  BannerModel.fromFireStore(DocumentSnapshot snapshot){
    id = snapshot["id"];
    imageUrl = snapshot["bannerImageUrl"];
  }
}