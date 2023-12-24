import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:muslim_soul/constans/constants.dart';
import 'package:muslim_soul/screens/Quran_screen.dart';
import 'package:muslim_soul/screens/home_screen.dart';
import 'package:muslim_soul/screens/prayer_scren.dart';
import 'package:muslim_soul/screens/qari_screen.dart';
import 'package:muslim_soul/screens/qiblah.dart';
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectIndex = 0;
  List<Widget> _widgetslist = [
    HomeScreen(),
    QuranScreen(),
   QariListScreen(),
    Prayerscreen(),
    Qiblah(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _widgetslist[selectIndex],
        bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(
                icon: Image.asset(
                  'assets/home.png',
                  color: Colors.white,
                ),
                title: 'Home'),
            TabItem(
                icon: Image.asset(
                  'assets/holyQuran.png',
                  color: Colors.white,
                ),
                title: 'Quran'),
            TabItem(
                icon: Image.asset(
                  'assets/audio.png',
                  color: Colors.white,
                ),
                title: 'Audio'),
            TabItem(
                icon: Image.asset(
                  'assets/mosque.png',
                  color: Colors.white,
                ),
                title: 'Prayer'),
            TabItem(
                icon: Image.asset(
                  'assets/icons8-qibla-50.png',
                  color: Colors.white,
                ),
                title: 'Qiblah'),
          ],
          initialActiveIndex: 0,
          backgroundColor: Constants.Kprimary,
          //op
          activeColor: Constants.Kprimary,
          // tional, default as 0
          onTap: UpdateIndex,
        ),
      ),
    );
  }

  void UpdateIndex(index) {
    setState(() {
      selectIndex = index;
    });
  }
}
