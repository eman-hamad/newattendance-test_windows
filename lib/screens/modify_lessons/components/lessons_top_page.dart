import 'package:flutter/material.dart';

class Lessons_top_page extends StatelessWidget {
  const Lessons_top_page({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 75,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.blue,
                    fontFamily: 'AraHamah1964B-Bold'),
              ),
              // SizedBox(
              //   width: 20,
              // ),
              // CircleAvatar(
              //     minRadius: 30,
              //     backgroundImage: AssetImage('assets/images/pic.png')),
            ],
          ),
        )
      ],
    );
  }
}
