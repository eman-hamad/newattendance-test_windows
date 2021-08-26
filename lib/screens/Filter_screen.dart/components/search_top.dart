import 'package:attendance/managers/Student_manager.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search_top extends StatefulWidget {
  Search_top(
      {Key? key, required this.size, this.arrowback = true, this.groupId})
      : super(key: key);
  final Size size;
  final bool arrowback;
  final String? groupId;

  @override
  _Search_topState createState() => _Search_topState();
}

class _Search_topState extends State<Search_top> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: widget.size.height * .12,
      width: widget.size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: widget.size.height * .05,
                  // width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: (1),
                        color: Colors.grey,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Form(
                        child: Expanded(
                          child: TextFormField(
                            controller: searchcontroller,
                            onChanged: (value) {
                              // if (value.isEmpty) {
                              //   Provider.of<StudentManager>(context,
                              //           listen: false)
                              //       .resetlist();
                              //   Provider.of<StudentManager>(context,
                              //           listen: false)
                              //       .getMoreDatafiltered(widget.groupId!);
                              //   FocusScopeNode currentFocus =
                              //       FocusScope.of(context);

                              //   if (!currentFocus.hasPrimaryFocus) {
                              //     currentFocus.unfocus();
                              //   }
                              // }
                            },
                            decoration: InputDecoration(
                              hintText: "بحث",
                              hintStyle: TextStyle(fontFamily: 'GE-light'),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                            ),
                          ),
                        ),
                      ), //test
                      InkWell(
                          onTap: () {
                            // if (searchcontroller.text == '') {
                            //   Provider.of<StudentManager>(context,
                            //           listen: false)
                            //       .resetlist();
                            //   Provider.of<StudentManager>(context,
                            //           listen: false)
                            //       .getMoreDatafiltered(widget.groupId!);
                            //   FocusScopeNode currentFocus =
                            //       FocusScope.of(context);

                            //   if (!currentFocus.hasPrimaryFocus) {
                            //     currentFocus.unfocus();
                            //   }
                            // } else {
                            //   Provider.of<StudentManager>(context,
                            //           listen: false)
                            //       .getDataSearch(
                            //           widget.groupId!, searchcontroller.text);
                            //   FocusScopeNode currentFocus =
                            //       FocusScope.of(context);

                            //   if (!currentFocus.hasPrimaryFocus) {
                            //     currentFocus.unfocus();
                            //   }
                            // }

                            // Provider.of<StudentManager>(context, listen: false)
                            //     .getDataSearch(groupId!, searchcontroller.text);
                          },
                          // onTap: () async {
                          //   showSearch(
                          //       context: context, delegate: StudentSearch());
                          // },
                          child: Icon(Icons.search))
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5),
              widget.arrowback
                  ? InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
