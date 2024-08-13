import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class KhaltiPaymentView extends StatefulWidget {
  const KhaltiPaymentView({super.key});

  @override
  State<KhaltiPaymentView> createState() => _KhaltiPaymentViewState();
}

class _KhaltiPaymentViewState extends State<KhaltiPaymentView> {
  // late final Future<Khalti> khalti;

  // @override
  // void initState() {
  //   super.initState();
  //   final payConfig = KhaltiPayConfig(
  //     publicKey: '__live_public_key__', // Merchant's public key
  //     pidx: pidx, // This should be generated via a server side POST request.
  //     environment: Environment.prod,
  //   );

  //   khalti = Khalti.init(
  //     enableDebugging: true,
  //     payConfig: payConfig,
  //     onPaymentResult: (paymentResult, khalti) {
  //       log(paymentResult.toString());
  //     },
  //     onMessage: (
  //       khalti, {
  //       description,
  //       statusCode,
  //       event,
  //       needsPaymentConfirmation,
  //     }) async {
  //       log(
  //         'Description: $description, Status Code: $statusCode, Event: $event, NeedsPaymentConfirmation: $needsPaymentConfirmation',
  //       );
  //     },
  //     onReturn: () => log('Successfully redirected to return_url.'),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Khalti Payment"),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          payWithKhalti();
        },
        child: const Text("Pay with khalti"),
      )),
    );
  }

  payWithKhalti() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "ProductId",
          productName: "Product Name"),
      preferences: [PaymentPreference.khalti],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: const Text("Payment Successful"), actions: [
            SimpleDialogOption(
              child: const Text("ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]);
        });
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }

  void onCancel() {
    debugPrint("cancelled");
  }
}
