import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:muslim_soul/models/aya_of_day.dart';
import 'package:muslim_soul/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices _apiServices = ApiServices();
void setData()async{
  final prefs = await SharedPreferences.getInstance();
prefs.setBool("alreadyUsed", true);
}
  @override
  void initState() {

    super.initState();
    setData();
  }
  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('en');
    var _hijri = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat('EEE , d MMM yyyy');
    var formatted = format.format(day);

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/background_img.jpg'),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    formatted,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                RichText(
                    text: TextSpan(children: <InlineSpan>[
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _hijri.hDay.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _hijri.longMonthName,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                    '${_hijri.hYear} AH',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                    ),
                  ),
                      )),
                ])),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.only(top: 10, bottom: 20),
            child: Column(
              children: [
                FutureBuilder<AyaOfTheDay>(
                    future: _apiServices.getAyaOfTheDay(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Icon(Icons.sync_problem);
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return CircularProgressIndicator();
                        case ConnectionState.done:

                            return Container(
                              margin: EdgeInsetsDirectional.all(16),
                              padding: EdgeInsetsDirectional.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Quran Aya of the day',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black, fontSize: 18
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 0.5,
                                  ),

                                  Text(

                                    snapshot.data!.arText!,
                                    style: TextStyle(
                                      color: Colors.black54, fontSize: 18,
                                    ),textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    snapshot.data!.enTran!,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 18
                                    ), textAlign: TextAlign.center,
                                  ),
                                  RichText(
                                      text: TextSpan(children: <InlineSpan>[
                                        WidgetSpan(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Text(
                                                snapshot.data!.surNumber!.toString(),
                                                style: TextStyle(fontSize: 16),
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        WidgetSpan(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Text(
                                                snapshot.data!.surEnName!,
                                                style: TextStyle(
                                                    fontSize: 16),),
                                            ))
                                      ])),
                                ],
                              ),
                            );
                          }
                      }
                    ),
              ],
            ),
          )),
        ],
      )),
    );
  }
}
