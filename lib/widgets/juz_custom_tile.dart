import 'package:flutter/material.dart';
import 'package:muslim_soul/constans/constants.dart';
import 'package:muslim_soul/models/juz.dart';

class JuzCustomTile extends StatelessWidget {
  final List<JuzAyahs> list;
  final int index;

  JuzCustomTile({required this.list, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Container(
        
        padding: EdgeInsets.all(.16),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black54 ,
            blurRadius: 0.3,
          ),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              list[index].ayahNumber.toString(),
            ),
            Text(
              list[index].ayahsText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.end,
            ),
            Text(
              list[index].surahName,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
