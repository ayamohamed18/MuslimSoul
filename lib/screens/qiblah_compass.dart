import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:muslim_soul/widgets/location_error_widget.dart';
import 'package:muslim_soul/widgets/qiblah_compass_widget.dart';
class QiblahCompass extends StatefulWidget {
  const QiblahCompass({Key? key}) : super(key: key);

  @override
  State<QiblahCompass> createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {
  final _locationStreamController=StreamController<LocationStatus>.broadcast();

  get stream =>_locationStreamController.stream;
  Future<void>_checkLoacationStatus()async{
    final locationStatus= await FlutterQiblah.checkLocationStatus();
    if(locationStatus.enabled&&locationStatus.status==LocationPermission.denied){
      await FlutterQiblah.requestPermissions();
      final s=await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    }else{_locationStreamController.sink.add(locationStatus);}
  }
  @override
  void initState() {
    super.initState();
    _checkLoacationStatus();
  }
  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(stream: stream,builder: (BuildContext context,AsyncSnapshot snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.data!.enabled==true){
          switch(snapshot.data!.status){
            case LocationPermission.always:
            case LocationPermission.whileInUse:
              return QibalhCompassWidget();
            case LocationPermission.denied:
              return LocationErrorWidget(error: "Location service permission denied.",callBack: _checkLoacationStatus);
            case LocationPermission.deniedForever:
              return LocationErrorWidget();
            default:
              return Container();
          }
        }else{return LocationErrorWidget(error: "Please enable location service.",callBack: _checkLoacationStatus);}
      }),
    );
  }
}
