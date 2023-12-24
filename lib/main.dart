import 'package:flutter/material.dart';
import 'package:muslim_soul/screens/juz_screen.dart';
import 'package:muslim_soul/screens/splash_screen.dart';
import 'package:muslim_soul/constans/constants.dart';
import 'package:muslim_soul/screens/surah_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muslim Soul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Constants.KswatchColor,
        primaryColor: Constants.Kprimary,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(),
      routes:{
       JuzScreen.id:(context)=>JuzScreen(),
        SurahDetail.id:(context)=> SurahDetail(),
      },
    );
  }
}
