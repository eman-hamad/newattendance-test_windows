import 'package:flutter/material.dart';

class Title_with_pic extends StatelessWidget {
  const Title_with_pic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Spacer(),
          Text(
            'تسجيل طالب',
            style: TextStyle(
                color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
              minRadius: 30,
              backgroundImage: AssetImage('assets/images/pic.png')),
          Spacer()
        ],
      ),
    );
  }
}
