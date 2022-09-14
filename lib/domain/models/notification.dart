import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationDataModel{
  String? notificationId;
  String? notificationTitle;
  String? notificationBody;
  Timestamp? notificationTimestamp;


  NotificationDataModel({
    this.notificationId,
    this.notificationTitle,
    this.notificationBody,
    this.notificationTimestamp,

  }
      );

  factory NotificationDataModel.formFireStore(DocumentSnapshot snapshot){
    final data = snapshot.data()as Map;
    return NotificationDataModel(
      notificationId : data["notification"]["notificationId"],
      notificationTitle: data["notification"]["notificationTitle"],
      notificationBody : data["notification"]["notificationBody"],
      notificationTimestamp : data["notification"]["timestamp"],

    );
  }
}