import 'package:flutter/material.dart';

import '../../../constants.dart';

class Students_Page_Title extends StatelessWidget {
  const Students_Page_Title({
    Key? key,
    required this.title,
  }) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                  fontFamily: 'GE-bold',
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
