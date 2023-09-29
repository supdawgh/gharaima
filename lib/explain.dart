import 'package:flutter/material.dart';
import 'package:gm/chat.dart';
import 'package:gm/otp.dart';
import 'package:gm/workerdash.dart';
import 'package:http/http.dart';

class MyExplain extends StatefulWidget {
  const MyExplain({super.key});

  @override
  State<MyExplain> createState() => _MyExplainState();
}

class _MyExplainState extends State<MyExplain> {
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
            child: const Column(
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
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 300,
              left: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyDash(),
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
