import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'dart:math' show pi;

class QibalhCompassWidget extends StatelessWidget {
  final _compassSvg = SvgPicture.asset("assets/compass.svg");
  final _needleSvg = SvgPicture.asset(
    "assets/needle.svg",
    fit: BoxFit.contain,
    height: 300,
    alignment: Alignment.center,
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final qiblahDirection = snapshot.data!;
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Transform.rotate(
                angle: qiblahDirection.direction * (pi / 180) * -1,
                child: _compassSvg,
              ),
              Transform.rotate(
                angle: qiblahDirection.qiblah * (pi / 180) * -1,
                child: _needleSvg,
                alignment: Alignment.center,
              ),
              Positioned(bottom: 8,child:Text("${qiblahDirection.offset.toStringAsFixed(3)}") ),
            ],
          );
        });
  }
}
