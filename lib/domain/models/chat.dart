import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDataModel {
  String? senderId;
  String? receiverId;
  String? messageBody;
  Timestamp? timestamp;

  MessageDataModel(
      {this.senderId, this.receiverId, this.messageBody, this.timestamp});

  factory MessageDataModel.fromFireStore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    return MessageDataModel(
      senderId: data["senderId"],
      receiverId: data["receiverId"],
      messageBody: data["messageBody"],
      timestamp: data["timestamp"],
    );
  }
}
