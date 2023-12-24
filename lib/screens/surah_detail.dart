import 'package:flutter/material.dart';
import 'package:muslim_soul/constans/constants.dart';
import 'package:muslim_soul/models/translation.dart';
import 'package:muslim_soul/services/api_services.dart';
import 'package:muslim_soul/widgets/translation_tile.dart';

class SurahDetail extends StatefulWidget {
static const String id="surahDetail_screen";
  @override
  State<SurahDetail> createState() => _SurahDetailState();
}

class _SurahDetailState extends State<SurahDetail> {
  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _apiServices.getTranslation(Constants.surahIndex!),
          builder:( BuildContext context, AsyncSnapshot<SurahTextList> snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.textList.length,
                  itemBuilder: (context, index){
                  return TranslationTile(index: index, surahText: snapshot.data!.textList[index]);
                  });
            }
            else return Center(child: Text("Translation Not Found"),);
          }



      )


    );
  }
}
