import 'package:flutter/material.dart';
import 'package:gm/chat.dart';
import 'package:gm/cleaning.dart';
import 'package:gm/electricity.dart';
import 'package:gm/login.dart';
import 'package:gm/otp.dart';
import 'package:gm/plumbing.dart';
import 'package:gm/profile.dart';
import 'package:gm/register.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() {
  String firstName = "";
  String lastName = "";
  int contactNo = 0;
  String address = "";
  String password = "";

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => MyLogin(
            firstName: firstName,
            lastName: lastName,
            contactNo: '',
            address: address,
            password: password),
        'register': (context) => MyRegister(
            firstName: firstName,
            lastName: lastName,
            contactNo: contactNo,
            address: address,
            password: password),
        'worker': (context) => const MyWorker(),
        'otp': (context) => MyOtp(
            firstName: firstName,
            lastName: lastName,
            contactNo: contactNo,
            address: address,
            password: password),
        'dash': (context) => const MyDash(),
        'plumbing': (context) => const MyPlumber(),
        'cleaning': (context) => const MyClean(),
        'electricity': (context) => const MyElectricity(),
        'profile': (context) => const MyProfile(),
        'chat': (context) => const MyChat(),
      }));
}
