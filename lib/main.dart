import 'package:flutter/material.dart';
import 'package:gm/chat.dart';
import 'package:gm/cleaning.dart';
import 'package:gm/electricity.dart';
import 'package:gm/explain.dart';
import 'package:gm/khalti.dart';
import 'package:gm/login.dart';
import 'package:gm/otp.dart';
import 'package:gm/plumbing.dart';
import 'package:gm/profile.dart';
import 'package:gm/register.dart';
import 'package:gm/workerdash.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'khalti.dart';

void main() {
  String firstName = "";
  String lastName = "";
  String contactNo = "";
  String address = "";
  String password = "";
  String id = "";

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      home: MyLogin(
          firstName: firstName,
          lastName: lastName,
          contactNo: contactNo,
          address: address,
          password: password),
      routes: {
        'login': (context) => MyLogin(
            firstName: firstName,
            lastName: lastName,
            contactNo: contactNo,
            address: address,
            password: password),
        'register': (context) => MyRegister(
            firstName: firstName,
            lastName: lastName,
            contactNo: contactNo,
            address: address,
            password: password),
        'worker': (context) => MyWorker(
              firstName: firstName,
              lastName: lastName,
              contactNo: contactNo,
              address: address,
              field: '',
              password: '',
            ),
        'workerdash': (context) => MyWorkerDash(contactNo: contactNo),
        'otp': (context) => MyOtp(
              firstName: firstName,
              lastName: lastName,
              contactNo: contactNo,
              address: address,
              password: password,
            ),
        'dash': (context) => const MyDash(),
        'plumbing': (context) => MyPlumber(
              id: id,
            ),
        'cleaning': (context) => MyClean(id: id),
        'electricity': (context) => MyElectricity(
              id: id,
            ),
        'profile': (context) => MyProfile(id: id),
        'explain': (context) => const MyExplain(),
        'chat': (context) => const MyChat(),
        'khalti': (context) => const MyApp(),
      }));
}
