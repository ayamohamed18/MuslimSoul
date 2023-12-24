import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:muslim_soul/screens/qiblah_compass.dart';

class Qiblah extends StatefulWidget {
  const Qiblah({Key? key}) : super(key: key);
  @override
  State<Qiblah> createState() => _QiblahState();
}

class _QiblahState extends State<Qiblah> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: _deviceSupport,
            builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error.toString()}"),
                );
              }
              if (snapshot.data!) {
                return QiblahCompass();
              } else {
                return const Center(
                  child: Text('Your device is not supported'),
                );
              }
            }),
      ),
    );
  }
}
