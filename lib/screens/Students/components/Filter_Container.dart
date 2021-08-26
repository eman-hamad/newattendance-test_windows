import 'package:flutter/material.dart';

import '../../../constants.dart';

class Filter_Container extends StatelessWidget {
  const Filter_Container({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        // horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Filter_Chip(
                title: 'اتصال طالب',
              ),
              Filter_Chip(
                title: 'رساله لطالب',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Filter_Chip(
                title: 'اشعار لطالب',
              ),
              Filter_Chip(
                title: 'اتصال ولى أمر',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Filter_Chip(
                title: 'رساله لولى الامر',
              ),
              Filter_Chip(
                title: 'اشعار لولى الامر',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Filter_Chip(
                title: 'واتس الى طالب',
              ),
              Filter_Chip(
                title: 'واتس الى ولى الامر',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Filter_Chip extends StatelessWidget {
  const Filter_Chip({
    Key? key,
    this.title,
  }) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Chip(
      backgroundColor: kbackgroundColor3,
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          child: Text(
            title,
            style: TextStyle(fontSize: 14, fontFamily: 'GE-medium'),
          ),
        ),
      ),
    );
  }
}
