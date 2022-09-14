import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_user/data/Network/FirebaseMessgingHandler.dart';
import 'package:food_user/data/Network/payment_api.dart';
import 'app/app.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initAppModule();
   await PaymentApi.initStripe();
   FirebaseMessagingHandler().initFirebaseNotificationMain();
  runApp(MyApp());
}
