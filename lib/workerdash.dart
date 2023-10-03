// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//http://192.168.1.75:5000/api/V1/worker/number/9808185333
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gm/globals.dart';
import 'package:gm/login.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class MyWorkerDash extends StatefulWidget {
  String contactNo;
  MyWorkerDash({super.key, required this.contactNo});

  @override
  State<MyWorkerDash> createState() => _MyWorkerDashState();
}

class _MyWorkerDashState extends State<MyWorkerDash> {
  Future<Map<String, dynamic>> getProfile() async {
    var id = widget.contactNo;
    print("Id is " + id);
    var url = Uri.parse('http://$ip:5000/api/V1/worker/byContact/$id');
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
  List<Map<String, dynamic>> data2 = [];

  @override
  void initState() {
    super.initState();

    getProfile().then((result) {
      setState(() {
        data = result;
      });
    });
    getRecentHires().then((result) {
      setState(() {
        data2 = result;
      });
    });
    fetchDataFromAPI();
  }

  var allWorkerHires = 0;
  var completedWorkerHires = 0;
  var hireRecordId = "";

  Future<List<Map<String, dynamic>>> getRecentHires() async {
    var id = widget.contactNo;
    var url = Uri.parse('http://$ip:5000/api/V1/hire/hireRequest/$id');
    try {
      var response = await http.get(url);
      print(response);
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['hireRecords'];
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

  Future<void> fetchDataFromAPI() async {
    var id = widget.contactNo;
    print("Id from fetch data from API is " + id);
    final response = await http.get(
        Uri.parse('http://localhost:5000/api/V1/worker/workerRequests/$id'));

    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        allWorkerHires = data['allWorkerHires'];
        print("all worker hires are");
        print(allWorkerHires);
        print("Completed worker hires");
        completedWorkerHires = data['completedWorkerHires'];
        print(completedWorkerHires);
      });
    } else {
      print("Here is the error");
      throw Exception('Failed to fetch data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      _top(),
      const SizedBox(
        height: 20.0,
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        //padding: EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Updates:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(20.0),
              height: 130.0,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ]),
              child: Column(children: [
                Text(
                  'Requests',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  allWorkerHires.toString(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ]),
            )),
            const SizedBox(
              width: 30.0,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(20.0),
              height: 130.0,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ]),
              child: Column(
                children: [
                  Text(
                    'Work Done',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    completedWorkerHires.toString(),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Recent hire requests',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
      ListView.builder(
          itemCount: data2.length,
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            final item = data2[index];
            return Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                                  //Image(image: Image.asset(imageUrl).image),
                                  //Image.network(imageUrl),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item['userData']['firstName'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(item['userData']['lastName'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                  Text(item['userData']['address'],
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                ],
                              ),
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
                                var itemId = item['_id'];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyCost(
                                              id: itemId,
                                              contactNo: widget.contactNo,
                                            )));
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
                  PopupMenuButton<String>(
                    offset: Offset(0, 40),
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onSelected: (value) {
                      if (value == 'logout') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => MyLogin2(
                                    firstName: 'firstName',
                                    lastName: '',
                                    contactNo: '',
                                    address: '',
                                    userId: '',
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
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "HI!! WELCOME BACK",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  //notification aune banaune
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          TextField(
            decoration: InputDecoration(
              hintText: "Search",
              fillColor: Colors.white,
              filled: true,
              suffixIcon: const Icon(Icons.filter_list),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              // contentPadding:const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0)
            ),
          )
        ],
      ),
    );
  }
}

//REVIEW AND COST
class MyCost extends StatefulWidget {
  final String id;
  final String contactNo;

  MyCost({required this.id, required this.contactNo});
  @override
  State<MyCost> createState() => _MyCostState();
}

class _MyCostState extends State<MyCost> {
  String serviceCost = "";

  Future<http.Response> addServiceCost() async {
    var id = widget.id;
    var url = Uri.parse('http://$ip:5000/api/V1/hire/addService/$id');
    var registerBody = {"serviceCost": phoneNumber};
    try {
      var response = await http.patch(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registerBody));
      return response;
    } catch (err) {
      print("Inside catch part");
      print(err);
      // You might want to handle the error here or rethrow it.
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 75.0, horizontal: 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Offer Your Fare : NPR',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          serviceCost = value;
                        },
                        maxLines: 2,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 214, 213, 213),
                          hintText: "Enter Cost!",
                          contentPadding: EdgeInsets.all(20.0),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Positioned(
                    right: 10,
                    top: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        var response = await addServiceCost();

                        if (response.statusCode == 200) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyWorkerDash(
                                contactNo: widget.contactNo,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Your credentails do not match !'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: Text('Bid the price'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(25, 135, 84, 10)),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
