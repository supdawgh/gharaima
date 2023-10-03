import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gm/chat.dart';
import 'package:gm/globals.dart';
import 'package:gm/otp.dart';
import 'package:gm/workerdash.dart';
import 'package:http/http.dart' as http;

class MyExplain extends StatefulWidget {
  final String id;
  final String userId;
  const MyExplain({super.key, required this.id, required this.userId});

  @override
  State<MyExplain> createState() => _MyExplainState();
}

class _MyExplainState extends State<MyExplain> {
  String message = " ";
  Future<void> createHireRecord() async {
    var url = Uri.parse('http://$ip:5000/api/V1/hire');
    var registerBody = {
      "user_id": widget.userId,
      "worker_id": widget.id,
      "serviceDate": DateTime.now().toIso8601String(),
      "message": message,
      "completed": false,
      "settled": false,
      "serviceCost": 0
    };
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registerBody));
      print(response);
      if (response.statusCode == 200) {
        print('POST request succeessful');
        print(response.body);
      } else {
        print("Else part");
        print(response.body);
      }
    } catch (err) {
      print("Inside catch part");
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
        ),
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 50, top: 50),
            child: const Text(
              'Explain Your Problem',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
                right: 50,
                left: 50),
            child: Column(
              children: [
                TextField(
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: "enter here",
                    filled: true,
                    fillColor: Color.fromARGB(255, 214, 213, 213),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 57),
                  ),
                  onChanged: (text) {
                    message = text;
                  },
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 300,
              left: 50,
              child: ElevatedButton(
                onPressed: () {
                  createHireRecord();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyDash(
                        userId: widget.userId,
                      ),
                    ),
                  );
                },
                child: Text('Send'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
                ),
              )),
        ]));
  }
}
