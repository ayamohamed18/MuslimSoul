import 'package:flutter/material.dart';

class LocationErrorWidget extends StatelessWidget {
  const LocationErrorWidget({Key? key, this.error, this.callBack})
      : super(key: key);
  final String? error;
  final Function? callBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.location_off,
            size: 150,
            color: Colors.red,
          ),
          SizedBox(
            height: 32,
          ),
          Text(
            error!,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(onPressed: (){if(callBack != null){
            callBack!();
          }}, child: Text('Retry'),)
        ],
      ),
    );
  }
}
