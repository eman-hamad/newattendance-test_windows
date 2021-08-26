import 'package:flutter/material.dart';

class TABLE_HEAD extends StatelessWidget {
  const TABLE_HEAD({Key? key, required this.size}) : super(key: key);
  final size;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      height: 30,
      width: double.infinity,
      child: Row(
        children: [
          Spacer(),
          CELL(height: 30, width: size.width / 8, text: 'الكل'),
          CELL(height: 30, width: size.width / 3, text: 'الاسم'),
          CELL(height: 30, width: size.width / 6, text: 'ID'),
          CELL(height: 30, width: size.width / 5, text: 'الموبايل'),
          CELL(height: 30, width: size.width / 7, text: 'تواصل'),
          // Comm_Options(height: 30, width: size.width / 7, text: 'تواصل'),
          Spacer(),
        ],
      ),
    );
  }
}

class CELL extends StatelessWidget {
  const CELL(
      {Key? key, required this.width, required this.height, required this.text})
      : super(key: key);
  final double width;
  final double height;
  final text;
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 12, fontFamily: 'GE-medium');
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      child: Center(
          child: Text(
        text,
        style: textStyle,
      )),
    );
  }
}

class Comm_Options extends StatefulWidget {
  const Comm_Options(
      {Key? key, required this.height, required this.width, required this.text})
      : super(key: key);

  @override
  _Comm_OptionsState createState() => _Comm_OptionsState();
  final double height;
  final double width;
  final String text;
}

class _Comm_OptionsState extends State<Comm_Options> {
  String dropdownvalue = 'Apple';
  var items = [
    'Apple',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      child: Container(
        width: 200,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            iconSize: 30,
            onChanged: (newval) {},
            icon: Icon(Icons.keyboard_arrow_down),
            items: [
              DropdownMenuItem(
                child: Text(
                  'اتصال طالب',
                  style: TextStyle(fontSize: 15),
                ),
                value: 'A',
              ),
              DropdownMenuItem(
                child: Text('اتصال ولى امر'),
                value: 'A',
              ),
              DropdownMenuItem(
                child: Text('طالب SMS'),
                value: 'A',
              ),
              DropdownMenuItem(
                child: Text('ولى امر SMS'),
                value: 'A',
              ),
              DropdownMenuItem(
                child: Text('واتساب طالب '),
                value: 'A',
              ),
              DropdownMenuItem(
                child: Text('واتساب ولى امر'),
                value: 'A',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
