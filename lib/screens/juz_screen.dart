import 'package:flutter/material.dart';
import 'package:muslim_soul/constans/constants.dart';
import 'package:muslim_soul/models/juz.dart';
import 'package:muslim_soul/services/api_services.dart';
import 'package:muslim_soul/widgets/juz_custom_tile.dart';

class JuzScreen extends StatefulWidget {

  static const String id = 'juz_screen';

  @override
  State<JuzScreen> createState() => _JuzScreenState();
}

class _JuzScreenState extends State<JuzScreen> {
  ApiServices _apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<JuzModel>(
            future: _apiServices.getJuz(Constants.juzIndex!),
            builder: (context, AsyncSnapshot<JuzModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                //print('${snapshot.data!.juzAyahs.length} length');
                return ListView.builder(
                  itemCount: snapshot.data!.juzAyahs.length,
                  itemBuilder: (context, index) {
                    return JuzCustomTile(
                        list: snapshot.data!.juzAyahs, index: index);
                  },
                );
              } else {
                return Center(
                  child: Text("Data Not Found"),
                );
              }
            }),
      ),
    );
  }
}
