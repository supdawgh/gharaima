// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gm/otp.dart';
import 'package:http/http.dart' as http;
<<<<<<< HEAD

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
=======
import 'package:flutter/material.dart';
import 'package:gm/globals.dart';
import 'package:flutter/material.dart';
import 'package:gm/otp.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({Key? key, required this.firstName, required this.lastName, required this.contactNo, required this.address, required this.password}) : super(key: key);
  
   final String firstName;
   final String lastName;
   final String contactNo;
   final String address;
   final String password;
   final bool isLoading=false;
>>>>>>> 9ab1bf284f639788b2de86f5dacb2244aa24045e

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  int phoneNumber = 0;
  String password = "";

  Future<void> loginUser() async {
    print("I have been called");
<<<<<<< HEAD
    var url = Uri.parse('http://172.16.7.116:5000/api/V1/users/login');
    var registerBody = {"phoneNumber": phoneNumber, "password": password};
=======
    var url = Uri.parse('http://$ip:5000/api/V1/users/login');
    var registerBody = {
      "phoneNumber":phoneNumber,
      "password":password
    };   
>>>>>>> 9ab1bf284f639788b2de86f5dacb2244aa24045e
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
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/Login.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
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
                      child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (value) {
                          phoneNumber = int.parse(value);
                        },
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          fillColor: Colors.grey[217],
                          filled: true,
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
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
                                    borderRadius: BorderRadius.circular(10),
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
                                  fontSize: 23, fontWeight: FontWeight.w700)),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black87,
                            child: IconButton(
                              color: Colors.grey,
                              onPressed: () {
                                loginUser();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyDash()),
                                );
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'continue with google',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Icon(
                                    Icons.apple,
                                    size: 30.0,
                                    color: Colors.black,
                                  )
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
<<<<<<< HEAD
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPass(
                                          firstName: widget.firstName,
                                          lastName: widget.lastName,
                                          contactNo: widget.contactNo,
                                          address: widget.address,
                                          password: widget.password)),
=======
                                  MaterialPageRoute(builder: (context) => ForgotPass(firstName: widget.firstName,
                                      lastName:widget.lastName,
                                      contactNo:widget.contactNo,
                                      address:widget.address,
                                      password:widget.password,
                                      )),
>>>>>>> 9ab1bf284f639788b2de86f5dacb2244aa24045e
                                );
                              },
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(
                                  //decoration: TextDecoration.underline,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      )
                    ],
                  )),
                ),
              ),
            ],
          )),
    );
  }
}

//ForGotPassWord
class ForgotPass extends StatefulWidget {
<<<<<<< HEAD
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
=======
  const ForgotPass({super.key, required this.firstName, required this.lastName, required this.contactNo, required this.address, required this.password});
  final String  firstName;
  final String  lastName;
  final String  contactNo;
  final String  address;
  final String  password;
  final bool isLoading=false;

>>>>>>> 9ab1bf284f639788b2de86f5dacb2244aa24045e

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

int phoneNumber = 0;
String password = "";

class _ForgotPassState extends State<ForgotPass> {
  // ignore: non_constant_identifier_names
  Future<void> ForgotPass() async {
    print("I have been called");
<<<<<<< HEAD
    var url = Uri.parse('http://192.168.1.68:5000/api/V1/users/login');
    var registerBody = {"phoneNumber": phoneNumber, "password": password};
=======
    var url = Uri.parse('http://$ip:5000/api/V1/users/login');
    var registerBody = {
      "phoneNumber":phoneNumber,
      "password":password
    };   
>>>>>>> 9ab1bf284f639788b2de86f5dacb2244aa24045e
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
        body: Stack(
          children: [
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
              ),
<<<<<<< HEAD
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.35,
                  right: 50,
                  left: 50),
              child: Center(
                child: Form(
                  child: Column(children: <Widget>[
                    TextFormField(
                      onChanged: (value) {
                        // ignore: unused_local_variable
                        var phoneNumber = int.parse(value);
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        fillColor: Colors.grey[217],
                        filled: true,
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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
                      width: double.infinity,
                    ),
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
                                  contactNo: 0,
                                  address: widget.address,
                                  password: widget.password)),
                        );
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyOtp(
                                    firstName: '',
                                    lastName: '',
                                    contactNo: 0,
                                    address: '',
                                    password: '')),
                          );
                        }
                      },

                      // ignore: sort_child_properties_last
                      child: const Text('Confirm'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(25, 135, 84, 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7))),
                    )
                  ]),
                ),
              ),
            ),
            /*const SizedBox(
=======
              ElevatedButton(onPressed:(){
                print('button clicked');
                ForgotPass();
                 Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyOtp(
                                      firstName: widget.firstName,
                                      lastName:widget.lastName,
                                      contactNo:widget.contactNo,
                                      address:widget.address,
                                      password:widget.password,
                                      isLoading:widget.isLoading,
                                    )),
                              );
                {
                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  const MyOtp(firstName: '', lastName: '', contactNo: '', address: '', password: '',isLoading: true,)),
                              );
                }
              },
              
              // ignore: sort_child_properties_last
              child: const Text('Confirm'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)
              )),
              )]
                  ),),),
                  
                 
                  
     ),
      /*const SizedBox(
>>>>>>> 9ab1bf284f639788b2de86f5dacb2244aa24045e
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Sign In', style:TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700)),
                          CircleAvatar(
                            radius: 20,
                              backgroundColor: Colors.black87,
                            child: IconButton(
                              color: Colors.grey,
                              onPressed: (){
                                
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MyDash()),
                                );
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          )
                        ],
                      ),*/
          ],
        ),
      ),
    );
  }
}
