// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gm/cleaning.dart';
import 'package:gm/electricity.dart';
//import 'package:gm/plumbing.dart';
import 'package:gm/globals.dart';
import 'package:gm/login.dart';
import 'package:gm/plumbing.dart';
import 'package:gm/profile.dart';
import 'package:gm/workerdash.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';

class MyOtp extends StatefulWidget {
  final String firstName;
  final String lastName;

  final String contactNo;
  final String address;
  final String password;

  const MyOtp({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.contactNo,
    required this.address,
    required this.password,
  });

/*  Widget _selectedCleaning({
required Color color,
required String title,
required String subtitle}){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 10.0),
      padding:const  EdgeInsets.only(left: 20),
      height: 120,
      width: 240,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      title,style: const TextStyle( 
        fontSize: 22,
         color: Colors.white),
    ),
    const SizedBox(
      height: 5,
),
Text(subtitle, style: const TextStyle( 
        fontSize: 22,
         color: Colors.white)),

  ],
),
);
}*/

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  String phoneOtp = "";

  void triggerUserRegistered() {
    setState(() {
      userRegistered = true;
    });
  }

  bool userRegistered = false;
  Future<bool> validateOtp() async {
    var url = Uri.parse('http://$ip:5000/api/V1/system/validateOtp');
    var registerBody = {"phoneNumber": widget.contactNo, "userOtp": phoneOtp};
    print(registerBody);
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registerBody));
      print(response);
      if (response.statusCode == 200) {
        print('POST request succeesful');
        var registerStatus = registerUser();
        return registerStatus;
      } else {
        return false;
      }
    } catch (err) {
      throw err;
    }
  }

  Future<bool> registerUser() async {
    var url = Uri.parse('http://$ip:5000/api/V1/users/register');
    var registerBody = {
      "firstName": widget.firstName,
      "lastName": widget.lastName,
      "phoneNumber": widget.contactNo,
      "address": widget.address,
      "password": widget.password
    };
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registerBody));
      print(response);
      if (response.statusCode == 201) {
        print('POST request succeesful');
        print(response);
        triggerUserRegistered();
        return true;
      } else {
        print("Else part");
        print(response.body);
        return false;
      }
    } catch (err) {
      print("Inside catch part");
      print(err);
      throw err;
    }
  }

  // List<TextEditingController> otpContollers=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
          title: const Text(''),
        ),
        backgroundColor: const Color.fromRGBO(223, 223, 223, 10),
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('OTP Verification',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'We need to register your phone before getting started!',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    onChanged: (value) {
                      phoneOtp = value;
                    },
                    length: 6,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                  ),
                  const SizedBox(
                    height: 30,
                    width: double.infinity,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool validateValue = await validateOtp();
                      if (validateValue == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyDash()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Your otp do not match !'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text('Confirm'),
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(25, 135, 84, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7))),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

//OTP2
class MyOtp2 extends StatefulWidget {
  final String firstName;
  final String lastName;

  final String contactNo;
  final String address;
  final String field;
  final String password;
  const MyOtp2(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.contactNo,
      required this.address,
      required this.field,
      required this.password});

  @override
  State<MyOtp2> createState() => _MyOtp2State();
}

class _MyOtp2State extends State<MyOtp2> {
  String phoneOtp = "";

  void triggerUserRegistered() {
    setState(() {
      userRegistered = true;
    });
  }

  bool userRegistered = false;
  Future<bool> validateOtp() async {
    var url = Uri.parse('http://$ip:5000/api/V1/system/validateOtp');
    var registerBody = {"phoneNumber": widget.contactNo, "userOtp": phoneOtp};
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registerBody));
      print(response);
      if (response.statusCode == 200) {
        var registerStatus = registerWorker();
        return registerStatus;
      } else {
        return false;
      }
    } catch (err) {
      throw err;
    }
  }

  Future<bool> registerWorker() async {
    var url = Uri.parse('http://$ip:5000/api/V1/worker/register');
    var registerBody = {
      "firstName": widget.firstName,
      "lastName": widget.lastName,
      "phoneNumber": widget.contactNo,
      "address": widget.address,
      "field": widget.field,
      "password": widget.password
    };
    print(registerBody);
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registerBody));
      print(response);
      if (response.statusCode == 201) {
        print('POST request succeesful');
        print(response);
        return true;
      } else {
        print("Else part");
        print(response.body);
        return false;
      }
    } catch (err) {
      print("Inside catch part");
      print(err);
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
          title: const Text(''),
        ),
        backgroundColor: const Color.fromRGBO(223, 223, 223, 10),
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('OTP Verification',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'We need to register your phone before getting started!',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    onChanged: (value) {
                      phoneOtp = value;
                    },
                    length: 6,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                  ),
                  const SizedBox(
                    height: 30,
                    width: double.infinity,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool validateValue = await validateOtp();
                      if (validateValue == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyWorkerDash(
                                    contactNo: widget.contactNo,
                                  )),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Your otp do not match !'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text('Confirm'),
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(25, 135, 84, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7))),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

//DASHBOARD

class MyDash extends StatefulWidget {
  const MyDash({Key? key}) : super(key: key);

  @override
  State<MyDash> createState() => _MyDashState();
}

class _MyDashState extends State<MyDash> {
  get children => int;

  get prefixIcon => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _top(),
          const SizedBox(
            height: 20.0,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 20.0,
          ),
          Container(
              height: 180.0,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 3 / 2),
                children: <Widget>[
                  IconButton(
                      icon: _gridItem(Icons.plumbing, "Plumbing"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPlumber(id: '')));
                      }),
                  IconButton(
                      icon: _gridItem(Icons.cleaning_services, "Cleaning"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyClean(
                                      id: '',
                                    )));
                      }),
                  IconButton(
                      icon: _gridItem(Icons.electrical_services, "Electricity"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyElectricity(id: '')));
                      }),
                  IconButton(
                      icon: _gridItem(Icons.brush_sharp, "Parlor"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPlumber(id: '')));
                      }),
                  IconButton(
                      icon: _gridItem(Icons.car_repair, "Mechanic"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPlumber(
                                      id: '',
                                    )));
                      }),
                  IconButton(
                      icon: _gridItem(Icons.format_paint_rounded, "Paint"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPlumber(
                                      id: '',
                                    )));
                      })
                ],
              )),

          //..

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Latest",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          _cardItem(1),
          // _cardItem(2),
          // _cardItem(3),
        ],
      ),
    );
  }

  //bottom
  _cardItem(image) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: <Widget>[
        Container(
          width: 100.0,
          height: 100.0,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
            'assets/carp.jpg',
          ))),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Electricity fix',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'get 15% off',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ]),
    );
  }

  _gridItem(icon, text) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
          child: Icon(
            icon,
            size: 25.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        )
      ],
    );
  }

//top
  _top() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
          color: const Color.fromRGBO(25, 135, 84, 10),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          )),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  PopupMenuButton<String>(
                    offset: Offset(0, 40),
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onSelected: (value) {
                      if (value == 'logout') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => MyLogin(
                                    firstName: 'firstName',
                                    lastName: '',
                                    contactNo: '',
                                    address: '',
                                    password: password))));
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'logout',
                        child: Text(
                          'Logout',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  const Text(
                    "HI!! WELCOME ",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MySearch(
                          id: '',
                        )),
              );
            },
            child: TextField(
                decoration: InputDecoration(
              hintText: "Search",
              fillColor: Colors.white,
              filled: true,
              suffixIcon: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MySearch(id: '')),
                  );
                },
                child: const Icon(Icons.arrow_forward),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            )),
          )
        ],
      ),
    );
  }
}

//SEARCH
class MySearch extends StatefulWidget {
  String id;
  MySearch({super.key, required this.id});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
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
    var url =
        Uri.parse('http://$ip:5000/api/V1/worker/category?category=cleaner');
    try {
      var response = await http.get(url);

      print(response);
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['workers'];
        List<Map<String, dynamic>> result =
            List<Map<String, dynamic>>.from(data);
        return result;
      } else {
        print("First else part");
        throw Exception('Failed to load data');
      }
    } catch (err) {
      print("Second else part");
      throw Exception('Failed to load data');
    }
  }

  List<String> imageUrls = [
    'https://randomuser.me/api/portraits/med/men/41.jpg',
    'https://randomuser.me/api/portraits/med/men/55.jpg',
    'https://randomuser.me/api/portraits/med/men/41.jpg',
    'https://randomuser.me/api/portraits/med/men/25.jpg',
    'https://randomuser.me/api/portraits/med/men/55.jpg',
    'https://randomuser.me/api/portraits/med/women/44.jpg',
    'https://randomuser.me/api/portraits/med/men/75.jpg',
  ];
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
            height: 40.0,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'YOUR SEARCH',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('',
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
                    "Profile",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                                    child: CircleAvatar(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.green,
                                      backgroundImage:
                                          NetworkImage(imageUrls[index]),
                                      //Image(image: Image.asset(imageUrl).image),
                                      //Image.network(imageUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(item['firstName'],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(item['lastName'],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                      Text(item['address'],
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                      RatingBar.builder(
                                        initialRating: 5,
                                        minRating: 1,
                                        maxRating: 5,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 12.0,
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
                                            builder: (context) =>
                                                MyProfile(id: widget.id)));
                                  },
                                  color: Colors.red,
                                  icon: const Icon(Icons.arrow_forward),
                                ),
                                // child:const Text('Hire',style: TextStyle(color:Colors.white),),
                              ),
                            ],
                          )),
                    ));
              }),
        ]));
  }
}
