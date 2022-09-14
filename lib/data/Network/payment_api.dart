import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_user/app/constants.dart';
import 'package:http/http.dart' as http;

class PaymentApi {
  final userEmail = FirebaseAuth.instance.currentUser?.email ?? "";
  static initStripe() {
    Stripe.publishableKey = AppConstants.publisherStripeKey;
  }

  Future<void> initPayment(
      {
        required double amount,
        required BuildContext context}) async {
    try {
      // 1. Create a payment intent on the server
      final response = await http.post(
          Uri.parse(
              'https://us-central1-food-72a02.cloudfunctions.net/stripePaymentIntentRequest'),
          body: {
            'email': userEmail,
            'amount': (amount * 100).toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: jsonResponse['paymentIntent'],
            merchantDisplayName: 'Ahmad Ellashy',
            customerId: jsonResponse['customer'],
            customerEphemeralKeySecret: jsonResponse['ephemeralKey'],

          ));
      await Stripe.instance.presentPaymentSheet();
    } catch (error) {
      if (error is StripeException) {
        throw error.error.localizedMessage!;
      } else {
        throw error;
      }
    }
  }
}
