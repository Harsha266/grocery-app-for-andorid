import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var firestoredb = Firestore.instance.collection("cart_items").snapshots();
  Razorpay _razorpay;
  int Totalamount=0;

  @override
  void initState() {
    _razorpay = Razorpay();
    // TODO: implement initState
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text("Your Cart"),
        centerTitle: true,
      ),
      body: StreamBuilder<Object>(
          stream: firestoredb,
          builder: (context, snapshot) {

            return Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Total Amount:   ₹ ${totalamount(snapshot,Totalamount)}', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        disabledColor: Colors.green,
                        child: Text(
                            "Make Payment", style: TextStyle(fontSize: 20)),
                        onPressed: () {
                          openCheckout();
                        },
                      ),
                    )
                  ],
                ),
              ),

            );
          }
      ),

    );
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_RhVMD1xNE9Nu1f',
      'amount': (Totalamount)*100,
      'name': 'Acme Corp.',
      'description': 'Payment for items',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("SUCCESS: " + response.paymentId)));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(
        "ERROR: " + response.code.toString() + " - " + response.message)));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("EXTERNAL_WALLET: " + response.walletName)));
  }

  totalamount(snapshot ,totalamount) {
     totalamount = 0;
    for (int i = 0; i < snapshot.data.documents.length; i++) {
              totalamount = totalamount + snapshot.data.documents[i]['prize'];


    }
     Totalamount=totalamount;
     print("${Totalamount}");
    return totalamount;
  }



}