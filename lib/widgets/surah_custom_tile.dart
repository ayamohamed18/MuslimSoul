import 'package:flutter/material.dart';
import 'package:muslim_soul/constans/constants.dart';
import 'package:muslim_soul/models/surah.dart';

Widget SurahCustomListTile({
  required Surah surah,
  required BuildContext context,
  required VoidCallback ontap,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 3.0,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 40,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                    width: .20,
                  ),

                  shape: BoxShape.circle,



                ),
                child: FittedBox(
                  child: Text(
                    surah.number.toString(),
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(
                            color: Colors.black54,
                            blurRadius: 12,
                            offset: const Offset(5, 5)
                        )],
                        fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.englishName!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(surah.englishNameTrans!)
                ],
              ),
              Spacer(),
              FittedBox(
                child: Text(
                  surah.name!,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
