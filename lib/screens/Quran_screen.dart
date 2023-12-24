import 'package:flutter/material.dart';
import 'package:muslim_soul/constans/constants.dart';
import 'package:muslim_soul/models/sajda.dart';
import 'package:muslim_soul/models/surah.dart';
import 'package:muslim_soul/screens/juz_screen.dart';
import 'package:muslim_soul/screens/surah_detail.dart';
import 'package:muslim_soul/services/api_services.dart';
import 'package:muslim_soul/widgets/sajda_custom_tile.dart';
import 'package:muslim_soul/widgets/surah_custom_tile.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.KswatchColor,
            title: Text(
              'Quran',
              style: TextStyle(fontWeight: FontWeight.bold, shadows: [
                Shadow(
                    color: Colors.black54,
                    blurRadius: 12,
                    offset: const Offset(5, 5)),
              ]),
            ),
            centerTitle: true,
            bottom: TabBar(tabs: [
              Text(
                'Surah',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  shadows: [
                    Shadow(
                        color: Colors.black54,
                        blurRadius: 12,
                        offset: const Offset(5, 5))
                  ],
                ),
              ),
              Text(
                'Sajda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  shadows: [
                    Shadow(
                        color: Colors.black54,
                        blurRadius: 12,
                        offset: const Offset(5, 5))
                  ],
                ),
              ),
              Text(
                'Juz',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  shadows: [
                    Shadow(
                        color: Colors.black54,
                        blurRadius: 12,
                        offset: const Offset(5, 5))
                  ],
                ),
              ),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              FutureBuilder(
                  future: _apiServices.getSurah(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Surah>> snapshot) {
                    if (snapshot.hasData) {
                      List<Surah>? surah = snapshot.data;
                      return ListView.builder(
                          itemCount: surah!.length,
                          itemBuilder: (context, index) => SurahCustomListTile(
                              surah: surah[index],
                              context: context,
                              ontap: () {
                                setState(() {
                                  Constants.surahIndex=(index+1);

                                });
                                Navigator.pushNamed(context, SurahDetail.id);
                              }));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
FutureBuilder(
    future: _apiServices.getSajda(),
    builder: (context,AsyncSnapshot<SajdaList>snapshot){
      if(snapshot.hasError){
        return Center(child: Text('Something went wrong'),);
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      return ListView.builder(
itemCount: snapshot.data!.sajdaAyahs.length,
          itemBuilder:(context,index)=>SajdaCustomTile(snapshot.data!.sajdaAyahs[index], context));
    }),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(0.8),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              Constants.juzIndex = (index + 1);
                            });
                            Navigator.pushNamed(context, JuzScreen.id);
                          },
                          child: Card(
                            shadowColor: Colors.blue[900],
                            //Constants.Kpurple,
                            elevation: 6,
                            color: Colors.white,
                            child: Center(
                                child: Text(
                              '${index + 1} ',
                              style: TextStyle(
                                color:Constants.Kprimary,

                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            )),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
