class Surah {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTrans;
  int? numberOfAyas;
  String? revelationType;

  Surah(
      {this.number,
      this.name,
      this.englishName,
      this.englishNameTrans,
      this.numberOfAyas,
      this.revelationType});
  factory Surah.fromJson(Map<String, dynamic> json){
    return Surah(
      number: json['number'],
       name: json['name'],
      englishName: json['englishName'],
      englishNameTrans: json['englishNameTranslation'],
      numberOfAyas: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }

}
