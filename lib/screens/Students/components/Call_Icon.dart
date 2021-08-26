import 'package:flutter/material.dart';

class Call_Icon extends StatelessWidget {
  const Call_Icon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        height: double.infinity,
        color: Colors.green,
        child: Icon(
          Icons.call_outlined,
          size: 20,
          color: Colors.white,
        ));
  }
}
