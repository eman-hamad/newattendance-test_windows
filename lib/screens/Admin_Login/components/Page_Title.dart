import 'package:flutter/material.dart';

import '../../../constants.dart';

class Page_Title extends StatelessWidget {
  const Page_Title({
    Key? key,
    required this.title,
  }) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 30, color: kTextColor1, fontWeight: FontWeight.bold),
      ),
    );
  }
}
