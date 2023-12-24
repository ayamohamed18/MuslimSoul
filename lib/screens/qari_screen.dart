import 'package:flutter/material.dart';
import 'package:muslim_soul/models/qari.dart';
import 'package:muslim_soul/screens/audio_surah_screen.dart';
import 'package:muslim_soul/services/api_services.dart';
import 'package:muslim_soul/widgets/quran_custom_tile.dart';

class QariListScreen extends StatefulWidget {
  const QariListScreen({Key? key}) : super(key: key);

  @override
  State<QariListScreen> createState() => _QariListScreenState();
}

class _QariListScreenState extends State<QariListScreen> {
  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Qari\'s',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: Colors.black54,
                      offset: Offset(0, 1),
                      spreadRadius: 0.0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Search'),
                      Spacer(),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Expanded(
                  child: FutureBuilder(
                      future: _apiServices.getQari(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Qari>> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Qari\'s data not found'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return QuranCustomTile(
                                qari: snapshot.data![index],
                                ontap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AudioSurahScreen(
                                        qari: snapshot.data![index],
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
