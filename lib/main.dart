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
  String userId = "";

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      home: MyLogin(
          firstName: firstName,
          lastName: lastName,
          contactNo: contactNo,
          address: address,
          userId: userId,
          password: password),
      routes: {
        'login': (context) => MyLogin(
            firstName: firstName,
            lastName: lastName,
            contactNo: contactNo,
            address: address,
            userId: userId,
            password: password),
        'register': (context) => MyRegister(
            firstName: firstName,
            lastName: lastName,
            contactNo: contactNo,
            address: address,
            userId: userId,
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
              userId: userId,
            ),
        'dash': (context) => MyDash(
              userId: userId,
            ),
        'plumbing': (context) => MyPlumber(
              id: id,
              userId: userId,
            ),
        'cleaning': (context) => MyClean(
              id: id,
              userId: userId,
            ),
        'electricity': (context) => MyElectricity(
              id: id,
              userId: userId,
            ),
        'profile': (context) => MyProfile(
              id: id,
              userId: userId,
            ),
        'explain': (context) => MyExplain(id: id, userId: userId),
        'chat': (context) => const MyChat(),
        'khalti': (context) => const MyApp(),
      }));
}
