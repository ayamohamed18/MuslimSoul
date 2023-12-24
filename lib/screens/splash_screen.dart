import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muslim_soul/constans/constants.dart';
import 'package:muslim_soul/screens/main_screen.dart';
import 'package:muslim_soul/screens/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool alreadyUsed = false;

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    alreadyUsed = prefs.getBool("alreadyUsed") ?? false;
  }

  @override
  void initState() {
    getData();
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return alreadyUsed ? MainScreen() : OnBoarding();
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Text(
              'Muslim Soul',
              style: TextStyle(color: Constants.Kprimary, fontSize: 30),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/islamic.png'),
          )
        ],
      ),
    ));
  }
}
