import 'package:flutter/material.dart';
import 'package:muslim_soul/constans/constants.dart';
import 'package:muslim_soul/models/translation.dart';

class TranslationTile extends StatelessWidget {
  final int index;
  final SurahText surahText;

  TranslationTile({required this.index, required this.surahText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(blurRadius: 1),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Constants.Kprimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      )),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height*0.001,
                    left: MediaQuery.of(context).size.height*0.010,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(

                        color:Constants.Kprimary,
                      ),
                      child: Text(
                        surahText.aya!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    )),
                Container(
                  margin:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.034,),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(

                        surahText.arabic_trans!,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
