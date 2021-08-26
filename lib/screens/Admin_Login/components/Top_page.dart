import 'package:flutter/material.dart';

import '../../../constants.dart';

class Top_Page extends StatelessWidget {
  const Top_Page({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kTextColor1,
      height: size.height * .35,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 60),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/logo.jpg',
        fit: BoxFit.fill,
        width: double.infinity,
      ),
    );
  }
}
