// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gm/globals.dart';
import 'package:form_validator/form_validator.dart';

import 'package:gm/otp.dart';
import 'package:gm/register.dart';
import 'package:gm/workerdash.dart';
import 'package:http/http.dart' as http;

class MyLogin extends StatefulWidget {
  const MyLogin(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.contactNo,
      required this.address,
      required this.password})
      : super(key: key);

  final String firstName;
  final String lastName;
  final String contactNo;
  final String address;
  final String password;

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int phoneNumber = 0;
  String password = "";

  Future<http.Response> loginUser() async {
    print("I have been called");
    var url = Uri.parse('http://$ip:5000/api/V1/users/login');
    var registerBody = {"phoneNumber": phoneNumber, "password": password};
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
            image: AssetImage('assets/Login.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 50, top: 130),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.45,
                      right: 50,
                      left: 50),
                  child: Center(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: ValidationBuilder()
                                  .phone()
                                  .minLength(
                                      10, 'Phone Number must be 10 characters')
                                  .build(),
                              onChanged: (value) {
                                phoneNumber = int.parse(value) ?? 0;
                              },
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Contact No.',
                                fillColor: Colors.grey[217],
                                filled: true,
                                prefixIcon: const Icon(Icons.phone),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              // validator: (val) {
                              //   if (val!.isEmpty) {
                              //     return "Required";
                              //   } else {
                              //      return null;
                              //   }
                              // },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Center(
                                child: Form(
                                  child: Column(children: <Widget>[
                                    TextFormField(
                                      onChanged: (value) {
                                        password = value;
                                      },
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        fillColor: Colors.grey[217],
                                        filled: true,
                                        prefixIcon: const Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        // errorText: password.isEmpty ? 'Required' : null,
                                      ),
                                      validator: ValidationBuilder()
                                          .minLength(8,
                                              'Password must be at least 8 characters')
                                          .build(),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Sign In',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700)),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black87,
                                  child: IconButton(
                                    color: Colors.grey,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (phoneNumber != 0 &&
                                            password.isNotEmpty) {
                                          var response = await loginUser();

                                          if (response.statusCode == 200) {
                                            // ignore: use_build_context_synchronously
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyDash(),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Your credentails do not match !'),
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Phone Number or Password are Required!'),
                                          duration: Duration(seconds: 3),
                                        ));
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_forward),
                                  ),
                                )
                              ],
                            ),
                            
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'register');
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        //decoration: TextDecoration.underline,
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ForgotPass(
                                                  firstName: widget.firstName,
                                                  lastName: widget.lastName,
                                                  contactNo: '',
                                                  address: widget.address,
                                                  password: widget.password,
                                                )),
                                      );
                                    },
                                    child: const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        //decoration: TextDecoration.underline,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

//WORKER LOGIN
class MyLogin2 extends StatefulWidget {
  const MyLogin2(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.contactNo,
      required this.address,
      required this.password})
      : super(key: key);

  final String firstName;
  final String lastName;
  final String contactNo;
  final String address;
  final String password;

  @override
  State<MyLogin2> createState() => _MyLogin2State();
}

class _MyLogin2State extends State<MyLogin2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int phoneNumber = 0;
  String password = "";

  Future<http.Response> loginUser() async {
    print("I have been called");
    var url = Uri.parse('http://$ip:5000/api/V1/worker/login');
    var registerBody = {"phoneNumber": phoneNumber, "password": password};
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
            image: AssetImage('assets/Login.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 50, top: 130),
                      child: const Text(
                        'LOGIN ',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                    Text(
                      
                        '         as Worker ',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.45,
                      right: 50,
                      left: 50),
                  child: Center(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: ValidationBuilder()
                                  .phone()
                                  .minLength(
                                      10, 'Phone Number must be 10 characters')
                                  .build(),
                              onChanged: (value) {
                                phoneNumber = int.parse(value) ?? 0;
                              },
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Contact No.',
                                fillColor: Colors.grey[217],
                                filled: true,
                                prefixIcon: const Icon(Icons.phone),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              // validator: (val) {
                              //   if (val!.isEmpty) {
                              //     return "Required";
                              //   } else {
                              //      return null;
                              //   }
                              // },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Center(
                                child: Form(
                                  child: Column(children: <Widget>[
                                    TextFormField(
                                      onChanged: (value) {
                                        password = value;
                                      },
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        fillColor: Colors.grey[217],
                                        filled: true,
                                        prefixIcon: const Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        // errorText: password.isEmpty ? 'Required' : null,
                                      ),
                                      validator: ValidationBuilder()
                                          .minLength(8,
                                              'Password must be at least 8 characters')
                                          .build(),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Sign In',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w700)),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black87,
                                  child: IconButton(
                                    color: Colors.grey,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (phoneNumber != 0 &&
                                            password.isNotEmpty) {
                                          var response = await loginUser();

                                          if (response.statusCode == 200) {
                                            // ignore: use_build_context_synchronously
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                     MyWorkerDash(contactNo: '',),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Your credentails do not match !'),
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'Phone Number or Password are Required!'),
                                          duration: Duration(seconds: 3),
                                        ));
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_forward),
                                  ),
                                )
                              ],
                            ),
                            
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyWorker(firstName: '', lastName: '', contactNo: '', address: '', field: '', password: password)));
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        //decoration: TextDecoration.underline,
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ForgotPass(
                                                  firstName: widget.firstName,
                                                  lastName: widget.lastName,
                                                  contactNo: '',
                                                  address: widget.address,
                                                  password: widget.password,
                                                )),
                                      );
                                    },
                                    child: const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        //decoration: TextDecoration.underline,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
//ForGotPassWord
class ForgotPass extends StatefulWidget {
  const ForgotPass(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.contactNo,
      required this.address,
      required this.password});
  final String firstName;
  final String lastName;
  final String contactNo;
  final String address;
  final String password;

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

int phoneNumber = 0;
String password = "";

class _ForgotPassState extends State<ForgotPass> {
  // ignore: non_constant_identifier_names
  Future<void> ForgotPass() async {
    print("I have been called");
    var url = Uri.parse('http://$ip:5000/api/V1/users/login');
    var registerBody = {"phoneNumber": phoneNumber, "password": password};
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registerBody));
      print(response);
      if (response.statusCode == 200) {
        print('POST request succeessful');
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
        /* decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/register.jpg'), fit: BoxFit.cover),),*/

        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Container(
            padding: const EdgeInsets.only(left: 110, top: 150),
            child: const Column(
              children: <Widget>[
                Text(
                  "FORGOT PASSWORD?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "we will send you a code in this e-mail!",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                )
              ],
            )),
        ElevatedButton(
          onPressed: () {
            print('button clicked');
            ForgotPass();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyOtp(
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        contactNo: widget.contactNo,
                        address: widget.address,
                        password: widget.password,
                      )),
            );
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyOtp(
                          firstName: '',
                          lastName: '',
                          contactNo: '',
                          address: '',
                          password: '',
                        )),
              );
            }
          },

          // ignore: sort_child_properties_last
          child: const Text('Confirm'),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7))),
        )
      ]),
    ));
  }
}
