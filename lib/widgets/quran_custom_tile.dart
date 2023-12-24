import 'package:flutter/material.dart';
import 'package:muslim_soul/models/qari.dart';

class QuranCustomTile extends StatefulWidget {
  const QuranCustomTile({Key? key, required this.qari, required this.ontap})
      : super(key: key);
  final Qari qari;
  final VoidCallback ontap;

  @override
  State<QuranCustomTile> createState() => _QuranCustomTileState();
}

class _QuranCustomTileState extends State<QuranCustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 0,
                  color: Colors.black54,
                  offset: Offset(0, 1),
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.qari.name!,
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
