import 'package:flutter/material.dart';
import 'package:muslim_soul/constans/constants.dart';
import 'package:muslim_soul/models/qari.dart';
import 'package:muslim_soul/models/surah.dart';
import 'package:muslim_soul/screens/audio_screen.dart';
import 'package:muslim_soul/services/api_services.dart';

class AudioSurahScreen extends StatefulWidget {
  const AudioSurahScreen({Key? key, required this.qari}) : super(key: key);
  final Qari qari;

  @override
  State<AudioSurahScreen> createState() => _AudioSurahScreenState();
}

class _AudioSurahScreenState extends State<AudioSurahScreen> {
  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Surah List',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
            future: _apiServices.getSurah(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
              if (snapshot.hasData) {
                List<Surah>? surah = snapshot.data;
                return ListView.builder(
                    itemCount: surah!.length,
                    itemBuilder: (context, index) => AudioTile(
                        surahName: snapshot.data![index].englishName,
                        TotalAya: snapshot.data![index].numberOfAyas,
                        number: snapshot.data![index].number,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AudioScreen(
                                  qari: widget.qari,
                                  index: index + 1,
                                  list: surah,
                                ),
                              ));
                        }));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}

Widget AudioTile(
    {required String? surahName,
    required TotalAya,
    required number,
    required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black54,
              offset: Offset(0, 3),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:  Border.all(
                  color: Colors.black54,
                  width: .20,
                ),
              ),
              child: FittedBox(
                child: Text(
                  number.toString(),
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
                  surahName!,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Total Aya : $TotalAya",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.play_circle_fill,
              color: Constants.Kprimary,
            )
          ],
        ),
      ),
    ),
  );
}
