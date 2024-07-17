import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment extends StatefulWidget {
  const RazorpayPayment({super.key});

  @override
  State<RazorpayPayment> createState() => _RazorpayPaymentState();
}

class _RazorpayPaymentState extends State<RazorpayPayment> {
  late Razorpay _razorpay;
  TextEditingController amtController = TextEditingController();

  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_text_1DP5mn0lF5G5ag',
      'amount': amount,
      'name': 'Naman Sharma',
      'prefill': {'contact': '1234567890', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful" + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed" + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet" + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Image.network(
              'https://repository-images.githubusercontent.com/389729275/371ba38b-8a03-4bff-916c-c3fa5396ceda',
              height: 100,
              width: 300,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Welcome to Razorpay Payment Gateway Integration',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: amtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Amount to be Paid';
                  }
                  return null;
                },
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: 'Enter Amount to be Paid',
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (amtController.text.toString().isNotEmpty) {
                  setState(() {
                    int amount = int.parse(amtController.text.toString());
                    openCheckout(amount);
                  });
                }
              },
              child: Padding(
                padding: EdgeInsets.all(
                  8,
                ),
                child: Text('Make Payment'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
