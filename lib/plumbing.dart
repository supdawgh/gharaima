// ignore: unused_import, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gm/profile.dart';
import 'package:http/http.dart' as http;
import 'package:gm/globals.dart';
import 'dart:convert';

class MyPlumber extends StatefulWidget {
  String id;
  String userId;
  MyPlumber({super.key, required this.id, required this.userId});

  @override
  State<MyPlumber> createState() => _MyPlumberState();
}

class _MyPlumberState extends State<MyPlumber> {
  List<dynamic> users = [];
  List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    super.initState();
    getCleaners().then((result) {
      setState(() {
        data = result;
      });
    });
  }

  Future<List<Map<String, dynamic>>> getCleaners() async {
    print("I have been called");
    var url =
        Uri.parse('http://$ip:5000/api/V1/worker/category?category=plumber');
    try {
      var response = await http.get(url);

      print(response);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['workers'];
        List<Map<String, dynamic>> result =
            List<Map<String, dynamic>>.from(data);
        return result;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          //  _top(),
          const SizedBox(
            height: 20.0,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Plumbing',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('List of Plumbers Available!!',
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Profiles",
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                final item = data[index];
                return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 55.0,
                                    height: 55.0,
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.green,
                                      backgroundImage: NetworkImage(
                                          "assets/profiles/and.jpg"),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(children: [
                                        Text(item['firstName'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(item['lastName'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                      Text(item['address'],
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      RatingBar.builder(
                                        initialRating: 0,
                                        minRating: 1,
                                        maxRating: 5,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 15.0,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color:
                                              Color.fromRGBO(25, 135, 84, 10),
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    child: Text('cost'),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 10.0,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    widget.id = item['_id'];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyProfile(
                                                  id: widget.id,
                                                  userId: widget.userId,
                                                )));
                                  },
                                  color: Colors.red,
                                  icon: const Icon(Icons.arrow_forward),
                                ),
                              ),
                            ],
                          )),
                    ));
              }),
        ]));
  }
}
