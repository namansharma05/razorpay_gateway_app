import 'package:flutter/material.dart';
import 'package:razorpay_gateway_app/razorpay_payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Razorpay Payment Gateway',
      home: RazorpayPayment(),
    );
  }
}
