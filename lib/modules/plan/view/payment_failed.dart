import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/custom_button.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentFailed extends StatefulWidget {
  const PaymentFailed({super.key});

  @override
  State<PaymentFailed> createState() => _PaymentFailedState();
}

class _PaymentFailedState extends State<PaymentFailed> {
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });

    super.initState();
  }

  var options = {
    'key': 'rzp_test_Zempc2zvqO0KsS',
    'amount': 1500,
    'name': 'Testing 1',
    'description': 'CAT Course',
    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
  };

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners

    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.payment_success,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.payment_failed,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle,
            size: 32,
            color: Colors.red,
          ),
          SizedBox(
            height: 12,
          ),
          CustomTextField(
            text: "Payment failed",
            styleFace: CustomTextStyles.sb18,
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Retry",
              onPressed: () {
                _razorpay.open(options);
              }),
        ],
      ),
    );
  }
}
