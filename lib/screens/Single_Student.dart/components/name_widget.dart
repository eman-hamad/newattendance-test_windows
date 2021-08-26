import 'package:flutter/material.dart';

class Name extends StatelessWidget {
  const Name({
    Key? key,
    required this.size,
    this.name,
    this.title = '',
    this.arrow = false,
  }) : super(key: key);

  final Size size;
  final String? name;
  final bool arrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.centerRight,
        width: size.width * .8,
        // margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 40,
        // width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Container(
          child: Row(
            children: [
              if (!arrow)
                Container(
                  // color: Colors.red,
                  width: 100,
                  child: Text(
                    title,
                    style: TextStyle(fontFamily: 'GE-medium'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              // if (!arrow) Spacer(),
              SizedBox(
                width: 10,
              ),
              Container(
                width: size.width * .8 / 2.5,
                child: Text(
                  name ?? '',
                  style: TextStyle(fontFamily: 'GE-medium'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              if (arrow) Spacer(),
              if (arrow)
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.black,
                )
            ],
          ),
        ),
      ),
    );
  }
}
