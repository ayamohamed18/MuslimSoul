import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:muslim_soul/constans/constants.dart';

class Prayerscreen extends StatefulWidget {
  const Prayerscreen({Key? key}) : super(key: key);

  @override
  State<Prayerscreen> createState() => _PrayerscreenState();
}

class _PrayerscreenState extends State<Prayerscreen> {
  Location location = new Location();
  LocationData? _currentPosition;
  double? latitude, longitude;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Prayer Timings',
            style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: FutureBuilder(
            future: getLoc(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Constants.Kprimary,
                  ),
                );
              }

              final myCoordinates=Coordinates(latitude!,longitude!);
              final params=CalculationMethod.egyptian.getParameters();
              params.madhab=Madhab.hanafi;
              final prayerTimes=PrayerTimes.today(myCoordinates,params);
              return Padding(padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Fajr',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Constants.Kprimary),),
                Text(DateFormat.jm().format(prayerTimes.fajr),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Constants.Kprimary),),

                      ],
                    ),
                  ),
                  Divider(color: Constants.Kpurple,thickness: 1,),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SunRise',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Constants.Kprimary),),
                        Text(DateFormat.jm().format(prayerTimes.sunrise),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Constants.Kprimary),),

                      ],
                    ),
                  ),
                  Divider(color: Constants.Kpurple,thickness: 1,),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Dhuhr',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Constants.Kprimary),),
                        Text(DateFormat.jm().format(prayerTimes.dhuhr),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Constants.Kprimary),),

                      ],
                    ),
                  ),
                  Divider(color: Constants.Kpurple,thickness: 1,),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Asr',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Constants.Kprimary),),
                        Text(DateFormat.jm().format(prayerTimes.asr),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Constants.Kprimary),),

                      ],
                    ),
                  ),
                  Divider(color: Constants.Kpurple,thickness: 1,),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Maghrib',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Constants.Kprimary),),
                        Text(DateFormat.jm().format(prayerTimes.maghrib),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Constants.Kprimary),),

                      ],
                    ),
                  ),
                  Divider(color: Constants.Kpurple,thickness: 1,),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Isha',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Constants.Kprimary),),
                        Text(DateFormat.jm().format(prayerTimes.isha),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Constants.Kprimary),),

                      ],
                    ),
                  ),

                ],
              ),
              );
            }),
      ),
    );
    ;
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Center(child:Container(child: Text('Please turn location on'),));
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Center(child:Container(child: Text('Please turn location on'),));
      }
    }
    _currentPosition = await location.getLocation();
    latitude = _currentPosition!.latitude;
    longitude = _currentPosition!.longitude;
  }
}
