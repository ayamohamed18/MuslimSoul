import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:muslim_soul/models/aya_of_day.dart';
import 'package:muslim_soul/models/juz.dart';
import 'package:muslim_soul/models/qari.dart';
import 'package:muslim_soul/models/sajda.dart';

import 'package:muslim_soul/models/surah.dart';
import 'package:muslim_soul/models/translation.dart';
import 'package:muslim_soul/screens/qari_screen.dart';

class ApiServices {

  List<Surah> list=[];
  final endPointUrl='http://api.alquran.cloud/v1/surah';




  Future<AyaOfTheDay> getAyaOfTheDay() async {
    String url =
        'http://api.alquran.cloud/v1/ayah/${random(1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return AyaOfTheDay.fromJSON(json.decode(response.body));
    } else {
      print('Fail to load');
      throw Exception("Failed to load post");
    }
  }
  Future<List<Surah>> getSurah() async {

    Response res = await http.get(Uri.parse(endPointUrl));
    if (res.statusCode == 200) {
     Map<String, dynamic> json=jsonDecode(res.body);
     json['data'].forEach((element){
if(list.length<114){
  list.add(Surah.fromJson(element));
}
     });
     print('ol ${list.length}');
     return list;
    } else {

      throw Exception("Can't get the surah");
    }
  }
  Future<JuzModel> getJuz(int index)async{
    String url='http://api.alquran.cloud/v1/juz/${index}/quran-uthmani';
    final response= await http.get(Uri.parse(url));
    if(response.statusCode==200){
      return JuzModel.fromJSON(json.decode(response.body));
    }
    else{
      throw Exception("Failed to load post");
    }

  }
  Future<SurahTextList> getTranslation(int index) async{
   final url="https://quranenc.com/api/v1/translation/sura/urdu_junagarhi/${index}";
   var res = await http.get(Uri.parse(url));
   return SurahTextList.fromJson(json.decode(res.body));
  }
List<Qari>qariList=[];

  Future<List<Qari>>getQari()async{
   String url='https://quranicaudio.com/api/qaris';
   final response=await http.get(Uri.parse(url));
  jsonDecode(response.body).forEach((element){
    if(qariList.length< 100){
      qariList.add(Qari.fromJson(element));
    }
  });
  return qariList;
  }

  Future<SajdaList> getSajda() async {
    String url =   "http://api.alquran.cloud/v1/sajda/en.asad";

    Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
     return SajdaList.fromJSON(json.decode(res.body));
    } else {

      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }




  random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }
}
