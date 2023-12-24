
class SurahTextList{
final List <SurahText> textList;
SurahTextList({required this.textList});

factory SurahTextList.fromJson(Map<String, dynamic>map){
  Iterable translation= map['result']  ;
    List<SurahText> list= translation.map((e) => SurahText.fromJson(e)).toList() ;
 return SurahTextList(textList: list);
}
}

class SurahText{
 String? sura;
  String? aya;
  String? arabic_trans;
// String? translation;

  SurahText({this.sura,this.aya,this.arabic_trans,});

  factory SurahText.fromJson(Map<String,dynamic>json){
 return SurahText(
   sura: json['sura'],
   aya: json['aya'],
   arabic_trans:json ['arabic_text'],
  // translation: json['translation'],
 );
 }

}