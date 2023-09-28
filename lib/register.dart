// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gm/globals.dart';
import 'package:gm/login.dart';
import 'package:gm/otp.dart';
import 'package:gm/workerdash.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class MyRegister extends StatefulWidget {
  String firstName;
  String lastName;
  String contactNo;
  String address;
  String password;

  MyRegister(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.contactNo,
      required this.address,
      required this.password})
      : super(
          key: key,
        );

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  
  Future<http.Response> sendOtp() async {
    var url = Uri.parse('http://$ip:5000/api/V1/system/sendOtp');
    var registerBody = {"phoneNumber": widget.contactNo};
    try {
      var response = await http.post(url,
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
    final _firstnameController = TextEditingController();
    final _lastnamecontroller = TextEditingController();
    final _phonenumberController = TextEditingController();
    final _addressController = TextEditingController();
    final _passwordController = TextEditingController();

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
                    top: MediaQuery.of(context).size.height * 0.22,
                    right: 50,
                    left: 50),
                child: Column(children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _firstnameController,
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
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _lastnamecontroller,
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
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          },
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
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.33,
                      right: 50,
                      left: 50),
                  child: Center(
                      child: Column(
                    children: [
                      TextFormField(
                        controller: _phonenumberController,
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
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _addressController,
                        onChanged: (value) {
                          widget.address = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Address',
                          fillColor: Colors.grey[217],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
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
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
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
                                onPressed: () async {
                                  _firstnameController.text;
                                  _lastnamecontroller.text;
                                  _phonenumberController.text;
                                  _addressController.text;
                                  print('firstname');

                                  if (widget.firstName.isNotEmpty &&
                                      widget.lastName.isNotEmpty &&
                                      widget.contactNo.isNotEmpty &&
                                      widget.address.isNotEmpty &&
                                      widget.password.isNotEmpty) {
                                    print('button Clicked');

                                    var response= await sendOtp();
                                    print(response.body);
                                    if (response.statusCode ==200){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyOtp(
                                                firstName: widget.firstName,
                                                lastName: widget.lastName,
                                                contactNo: widget.contactNo,
                                                address: widget.address,
                                                password: widget.password,
                                              )
                                          ),
                                    );
                                  }else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Invalid data entry !'),
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                         }
                                          else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'All fields are required. Please fill them up.'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyLogin2(
                                              firstName: '',
                                              lastName: '',
                                              contactNo: '',
                                              address: '',
                                              password: '',
                                            )));
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
  String firstName;
  String lastName;
  String contactNo;
  String address;
  String field;
  String password;

  MyWorker(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.contactNo,
      required this.address,
      required this.field,
      required this.password});

  @override
  State<MyWorker> createState() => _MyWorkerState();
}

class _MyWorkerState extends State<MyWorker> {
  var _value='-1';
   Future<http.Response> sendOtp() async {
    print("I have been called");
    var url = Uri.parse('http://$ip:5000/api/V1/system/sendOtp');
    var registerBody = {"phoneNumber": widget.contactNo};
    try {
      var response = await http.post(url,
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
                  top: MediaQuery.of(context).size.height * 0.22,
                  right: 50,
                  left: 50),
              child: Column(children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
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
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
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
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                      right: 7,
                      left: 7),
                  child: Center(
                    child: Column(children: [
                      TextFormField(
                        onChanged: (value) {
                          widget.contactNo = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Contact no.',
                          fillColor: Colors.grey[217],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          widget.address = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Address',
                          fillColor: Colors.grey[217],
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                     
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: DropdownButtonFormField(
                          
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius:BorderRadius.circular(7) )
                          ),
                          value:_value,
                          items: const [
                            DropdownMenuItem(child: Text('-Select Field-'),value:'-1'),
                            DropdownMenuItem(child: Text('Plumbing'),value:'plumber'),
                            DropdownMenuItem(child: Text('Cleaning'),value:'cleaner'),
                            DropdownMenuItem(child: Text('Electricity'),value:'electrician'),
                            DropdownMenuItem(child: Text('Mechanic'),value:'mechanic'),
                            DropdownMenuItem(child: Text('Parlour'),value:'parlour'),
                            DropdownMenuItem(child: Text('Painting'),value:'painter'),

                      
                          ],
                          onChanged: (v){
                            widget.field=v as String;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      TextFormField(
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
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
                                onPressed: () async {
                                  
                                  if (widget.firstName.isNotEmpty &&
                                      widget.lastName.isNotEmpty &&
                                      widget.contactNo.isNotEmpty &&
                                      widget.address.isNotEmpty &&
                                      widget.field.isNotEmpty) {
                                    print('button Clicked');
                                  var response = await  sendOtp();
                                  print(response.body);
                                if (response.statusCode==200)
                                {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyOtp2(
                                                  firstName: widget.firstName,
                                                  lastName: widget.lastName,
                                                  contactNo: widget.contactNo,
                                                  address: widget.address,
                                                  field: widget.field,
                                                  password: widget.password,
                                                )
                                          )
                                      );
                                  }
                                  else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Invalid data entry !'),
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        }
                                  else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'All Fields are Required. Please Fill Them Up!'),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            ),
                          ]),
                    ]),
                  ),
                )
              ]),
            ),
          ]),
        ));
  }
}
