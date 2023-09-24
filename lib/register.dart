import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gm/otp.dart';
import 'package:gm/workerdash.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
<<<<<<< HEAD
=======
import 'package:flutter/material.dart';
import 'package:gm/globals.dart';
>>>>>>> 9ab1bf284f639788b2de86f5dacb2244aa24045e

class MyRegister extends StatefulWidget {
  String firstName;
  String lastName;
  String contactNo;
  String address;
  String password;
  bool isLoading=false;

  MyRegister(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.contactNo,
      required this.address,
      required this.password})
      : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
<<<<<<< HEAD
  Future<void> sendOtp() async {
    var url = Uri.parse('http://192.168.1.68:5000/api/V1/system/sendOtp');
    var registerBody = {"phoneNumber": widget.contactNo};
=======

  Future<void> sendOtp() async {
    setState(() {
      widget.isLoading =true;
    });
    
    var url = Uri.parse('http://$ip:5000/api/V1/system/sendOtp');
    var registerBody = {
      "phoneNumber":widget.contactNo
    };   
>>>>>>> 9ab1bf284f639788b2de86f5dacb2244aa24045e
    print(registerBody);
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registerBody));
      print(response);
      if (response.statusCode == 201) {
        print('POST request succeesful');
        widget.isLoading=false;
        print(response);
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
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/register.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              Container(
                padding: const EdgeInsets.only(left: 30, top: 50),
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.30,
                    right: 50,
                    left: 50),
                child: Column(children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            widget.firstName = value;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.grey[217],
                              filled: true,
                              hintText: "First Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            widget.lastName = value;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.grey[217],
                              filled: true,
                              hintText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
<<<<<<< HEAD
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.40,
                      right: 50,
                      left: 50),
                  child: Center(
                      child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          widget.contactNo = int.parse(value);
                        },
                        //obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Contact no.',
                          fillColor: Colors.grey[217],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
=======
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.40,
                    right: 50,
                    left: 50),
                child: Center(
                    child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                       widget.contactNo = value;
                      },
                      //obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Contact no.',
                        fillColor: Colors.grey[217],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {
                        widget.address = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        fillColor: Colors.grey[217],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {
                        print("I am changing");
                        widget.password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        fillColor: Colors.grey[217],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sign Up',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w700)),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black87,
                          child: IconButton(
                            color: Colors.grey,
                            onPressed: () {
                              print('button Clicked');
                              sendOtp();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyOtp(
                                      firstName: widget.firstName,
                                      lastName:widget.lastName,
                                      contactNo:widget.contactNo,
                                      address:widget.address,
                                      password:widget.password,
                                      isLoading: widget.isLoading,
                                    )),
                              );
                            }, 
                            icon: const Icon(Icons.arrow_forward),
>>>>>>> 9ab1bf284f639788b2de86f5dacb2244aa24045e
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          widget.address = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          fillColor: Colors.grey[217],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          print("I am changing");
                          widget.password = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          fillColor: Colors.grey[217],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w700)),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black87,
                            child: IconButton(
                              color: Colors.grey,
                              onPressed: () {
                                print('button Clicked');
                                sendOtp();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyOtp(
                                          firstName: widget.firstName,
                                          lastName: widget.lastName,
                                          contactNo: widget.contactNo,
                                          address: widget.address,
                                          password: widget.password)),
                                );
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyWorker()));
                              },
                              child: const Text(
                                'Use as Worker',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              )),
                        ],
                      ),
                    ],
                  )))
            ])));
  }
}

//WORKER
class MyWorker extends StatefulWidget {
  const MyWorker({super.key});

  @override
  State<MyWorker> createState() => _MyWorkerState();
}

class _MyWorkerState extends State<MyWorker> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/workerR.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Container(
              padding: const EdgeInsets.only(left: 30, top: 50),
              child: const Text(
                'Worker Mode',
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25,
                  right: 50,
                  left: 50),
              child: Column(children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          // widget.firstName= value;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey[217],
                            filled: true,
                            hintText: "First Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          // widget.lastName = value;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey[217],
                            filled: true,
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                      right: 5,
                      left: 5),
                  child: Center(
                    child: Column(children: [
                      TextField(
                        onChanged: (value) {
                          // widget.contactNo = int.parse(value);
                        },
                        //obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Contact no.',
                          fillColor: Colors.grey[217],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
<<<<<<< HEAD
                      TextField(
                        onChanged: (value) {
                          // widget.address = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          fillColor: Colors.grey[217],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
=======
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                       // widget.lastName = value;
                      },
                          decoration: InputDecoration(
                              fillColor: Colors.grey[217],
                              filled: true,
                              hintText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: 5,
                    left: 5),
                child: Center(
                    child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                      // widget.contactNo = int.parse(value);
                      },
                      //obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Contact no.',
                        fillColor: Colors.grey[217],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {
                       // widget.address = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        fillColor: Colors.grey[217],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {
                       // widget.address = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Field',
                        fillColor: Colors.grey[217],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {
                        print("I am changing");
                       // widget.password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        fillColor: Colors.grey[217],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sign Up',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w700)),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black87,
                          child: IconButton(
                            color: Colors.grey,
                            onPressed: () {
                              print('button Clicked');
                             // sendOtp();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    /*builder: (context) => const MyOtp(firstName: '', lastName: '', contactNo: '', address: '', password: '', isLoading: true,
                                      //firstName: widget.firstName,
                                     // lastName:widget.lastName,
                                     // contactNo:widget.contactNo,
                                     // address:widget.address,
                                     // password:widget.password
                                    )),*/
                                    ///////////ahile ko lagi
                                  builder: (context)=> const MyWorkerDash(),
                                )
                              );
                            }, 
                            icon: const Icon(Icons.arrow_forward),
>>>>>>> 9ab1bf284f639788b2de86f5dacb2244aa24045e
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          // widget.address = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Field',
                          fillColor: Colors.grey[217],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          print("I am changing");
                          // widget.password = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          fillColor: Colors.grey[217],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sign Up',
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w700)),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black87,
                            child: IconButton(
                              color: Colors.grey,
                              onPressed: () {
                                print('button Clicked');
                                // sendOtp();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyOtp(
                                          firstName: '',
                                          lastName: '',
                                          contactNo: 0,
                                          address: '',
                                          password: ''
                                          //firstName: widget.firstName,
                                          // lastName:widget.lastName,
                                          // contactNo:widget.contactNo,
                                          // address:widget.address,
                                          // password:widget.password
                                          )),
                                );
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          )
                        ],
                      ),
                    ]),
                  ),
                )
              ]),
            ),
          ]),
        ));
  }
}
