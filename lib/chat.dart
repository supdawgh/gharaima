// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:convert';
import 'khalti.dart';

import 'package:flutter/material.dart';
import 'package:gm/profile.dart';
import 'package:gm/globals.dart';
import 'package:http/http.dart' as http;
import 'package:khalti_flutter/khalti_flutter.dart';


class MyChat extends StatefulWidget {
  const MyChat({super.key});


  @override
  State<MyChat> createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
       body:  Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor:  const Color.fromRGBO(25, 135, 84, 10),
    );
    
    
    
  }
}

class CustomerInfo {
  final String name;
  final String email;
  final String phone;

  CustomerInfo({
    required this.name,
    required this.email,
    required this.phone,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class AmountBreakdown {
  final String label;
  final int amount;

  AmountBreakdown({
    required this.label,
    required this.amount,
  });

  factory AmountBreakdown.fromJson(Map<String, dynamic> json) {
    return AmountBreakdown(
      label: json['label'],
      amount: json['amount'],
    );
  }
}
class ProductDetails {
  final String identity;
  final String name;
  final int totalPrice;
  final int quantity;
  final int unitPrice;

  ProductDetails({
    required this.identity,
    required this.name,
    required this.totalPrice,
    required this.quantity,
    required this.unitPrice,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      identity: json['identity'],
      name: json['name'],
      totalPrice: json['total_price'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
    );
  }
}

class PaymentData {
  final String returnUrl;
  final String websiteUrl;
  final int amount;
  final String purchaseOrderId;
  final String purchaseOrderName;
  final CustomerInfo customerInfo;
  final List<AmountBreakdown> amountBreakdown;
  final List<ProductDetails> productDetails;

  PaymentData({
    required this.returnUrl,
    required this.websiteUrl,
    required this.amount,
    required this.purchaseOrderId,
    required this.purchaseOrderName,
    required this.customerInfo,
    required this.amountBreakdown,
    required this.productDetails,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      returnUrl: json['return_url'],
      websiteUrl: json['website_url'],
      amount: json['amount'],
      purchaseOrderId: json['purchase_order_id'],
      purchaseOrderName: json['purchase_order_name'],
      customerInfo: CustomerInfo.fromJson(json['customer_info']),
      amountBreakdown: (json['amount_breakdown'] as List<dynamic>)
          .map((item) => AmountBreakdown.fromJson(item))
          .toList(),
      productDetails: (json['product_details'] as List<dynamic>)
          .map((item) => ProductDetails.fromJson(item))
          .toList(),
    );
  }
}

//body
/*class Body extends StatefulWidget {
 Body({super.key});

 @override
  State<Body> createState() => _BodyState();

 }
class _BodyState extends State<Body> {
  String referenceId='';
  @override
  Widget build(BuildContext context) {
    return Container(
              width: MediaQuery.of(context).size.width,
              padding:const EdgeInsets.symmetric(vertical:10.0,horizontal: 20.0),  
                 child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  <Widget>[
                          const SizedBox(height:10.0),
                                    Container(
                                      width: 400.0,
                                      height: 100.0,
                                      color: Color.fromARGB(255, 230, 226, 226),
                                      child: Container(
                                        margin: EdgeInsets.all(7.0),
                                        padding: EdgeInsets.all(7.0),
                                         child: Row(
                                            children: <Widget>[
                                            Text('Satisfied by the worker?',style: TextStyle(fontWeight: FontWeight.bold),),
                                            SizedBox(width: 70.0,),
                                             ElevatedButton(
                                                  onPressed: () {
                                                  payWithKhaltiInApp();
                                                    },
                                             child: const Text("Pay with Khalti")),
                                             Text(referenceId)
                                          ]
                                        ),
                                      ),
                                ),
        ]
      ),
    );
  }
}
payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 1000, //in paisa
        productIdentity: 'Product Id',
        productName: 'Product Name',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
        
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
      
          actions: [
            SimpleDialogOption(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    referenceId = success.idx;
                  });

                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(
      failure.toString(),
    );
  }

  void onCancel() {
    debugPrint('Cancelled');
  }
*/

//KHALTI
  class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _HomePageState();
}

class _HomePageState extends State<Body> {
  String referenceId = "";
  TextEditingController amountController =
      TextEditingController(); // Controller for the text field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Khalti Try Handim Na"),
        backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text field for entering the payment amount
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number, // Allow only numeric input
                decoration: const InputDecoration(
                  labelText: "Enter Amount",
                ),
              ),
            ),

            // Button to initiate payment
            ElevatedButton(
              onPressed: () {
                String paymentAmount =
                    amountController.text; // Get the amount from the text field
                payWithKhaltiInApp(int.parse(
                    paymentAmount)); // Convert the string to an integer
              },
              child: const Text("Pay with Khalti"),
            ),

            Text(referenceId),
          ],
        ),
      ),
    );
  }

  void payWithKhaltiInApp(int amount) {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: amount * 100, // Convert the amount to paisa
        productIdentity: 'Product Id',
        productName: 'Product Name',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) async {
    try {
      // Send the PaymentSuccessModel data as a GET request to the URL
      final response = await http.get(Uri.parse(
          'http://$ip:5000/api/v1/success?idx=${success.idx}&amount=${success.amount}&token=${success.token}'));

      if (response.statusCode == 200) {
        // Successfully sent data to the server
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Payment Successful'),
              actions: [
                SimpleDialogOption(
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      referenceId = success.idx;
                    });
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      } else {
        // Handle server response error
        print(
            'Failed to send data to server. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Error sending data to server: $e');
    }
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }

  void onCancel() {
    debugPrint('Cancelled');
  }

  @override
  void dispose() {
    amountController
        .dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }
}


class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 7.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 226, 218, 218),
      ),
      child: SafeArea(
        child: Row(children: [
         const  Icon(Icons.mic,color: Colors.grey,),
          const SizedBox(width: 10.0,),
          Expanded(child:
           Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            height: 50,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),),
            child: const Row(
              children: [
              SizedBox(width:10.0),
              Expanded(child: 
               TextField(
                decoration: InputDecoration(
                  hintText: 'Type Message',
                  border:InputBorder.none,
                ),
              ),
            ),
             Icon(
                Icons.camera_alt_outlined,
                color: Colors.grey,),

          ]
        ),
      ),
    )
       ]),
    ),
   );
  }
}


