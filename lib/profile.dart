// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gm/chat.dart';
import 'package:gm/cleaning.dart';
import 'package:gm/explain.dart';
import 'package:http/http.dart' as http;
import 'package:gm/globals.dart';
import 'dart:convert';

class MyProfile extends StatefulWidget {
  final String id;
  const MyProfile({super.key, required this.id});
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Future<Map<String, dynamic>> getProfile() async {
    var id = widget.id;
    var url = Uri.parse('http://$ip:5000/api/V1/worker/$id');
    try {
      var response = await http.get(url);

      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['indvWorker'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Failed to load data');
    }
  }

  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    getProfile().then((result) {
      setState(() {
        data = result;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
        ),
        body: ListView(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'YOU ARE ABOUT TO HIRE',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                  SizedBox(height: 30.0),
                  CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Color.fromRGBO(25, 135, 84, 10),
                    //backgroundImage: AssetImage('assets/dan.jpg'),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        data['firstName'],
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        data['lastName'],
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13.0,
                  ),
                  Text(
                    data['address'],
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Text('NRS.100',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Color.fromRGBO(25, 135, 84, 10))),
                  if (data.containsKey('review') && data['review'] is List)
                    SizedBox(
                      height: 17.0,
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Reviews',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      for (var review in data['review'])
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          color: const Color.fromARGB(255, 214, 213, 213),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RatingBar.builder(
                                initialRating:
                                    double.parse(review['rating'].toString()),
                                minRating: 1,
                                maxRating: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 5.0),
                                itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Color.fromRGBO(25, 135, 84, 10)),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('Review: ${review['message']}'),
                              Divider(),
                            ],
                          ),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyClean(id: '')));
                            },
                            child: const Text('Unhire'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7))),
                          )),
                          SizedBox(
                            height: 10.0,
                            width: 50.0,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyExplain()));
                            },
                            child: const Text('Hire'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(25, 135, 84, 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7))),
                          ))
                        ],
                      )
                    ],
                  )
                ],
              ))
        ]));
  }
}
