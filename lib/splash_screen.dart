import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/adminPannel.dart';
import 'Forms/personal_details.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var values = FirebaseAuth.instance.signInAnonymously();
    print(values);
    super.initState();
     Timer(
        const Duration(seconds: 5),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => adminPannel(selectedPage: 0,))));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/Images/splash_screen.jpg",),

            fit: BoxFit.cover)),
      ),
    );
  }
}
