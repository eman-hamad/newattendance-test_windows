import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/managers/Student_manager.dart';
import 'package:attendance/models/StudentSearchModel.dart';
import 'package:attendance/models/student.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

class Rows_Builder extends StatefulWidget {
  final groupId;
  final size;

  Rows_Builder({Key? key, this.size, this.groupId}) : super(key: key);

  @override
  _Rows_BuilderState createState() => _Rows_BuilderState();
}

class _Rows_BuilderState extends State<Rows_Builder> {
  void _tapFnc(StudentModelSearch student, String id) {
    Provider.of<AppStateManager>(context, listen: false)
        .goToSingleStudent(true, student, id);
  }

  bool _isLoading = true;
  ScrollController _sc = new ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<StudentManager>(context, listen: false).resetlist();

      try {
        await Provider.of<StudentManager>(context, listen: false)
            .getMoreDatafiltered(widget.groupId)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (e) {
        print(e);
      }
      if (!mounted) return;

      _sc.addListener(() {
        if (_sc.position.pixels == _sc.position.maxScrollExtent) {
          Provider.of<StudentManager>(context, listen: false)
              .getMoreDatafiltered(widget.groupId);
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _sc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<StudentManager>(context, listen: false).studentsSimple);
    return Expanded(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<StudentManager>(
                builder: (builder, studentmanager, child) {
                if (studentmanager.students.isEmpty &&
                    studentmanager.isloading == false) {
                  return Center(
                    child: Container(
                        child: Text(
                      'لا يوجد طلبه',
                      style: TextStyle(fontFamily: 'GE-medium'),
                    )),
                  );
                }
                if (studentmanager.isloading &&
                    studentmanager.students.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // if (studentmanager.isloading) {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }
                return ListView.builder(
                  controller: _sc,
                  itemCount: studentmanager.students.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: TABLE_ROW(
                          callfnc: () => launch(
                              "tel://${studentmanager.students[index].phone.toString()}"),
                          size: widget.size,
                          name: studentmanager.students[index].name!,
                          id: studentmanager.students[index].code?.name ??
                              ''.toString(),
                          mobile: studentmanager.students[index].phone!,
                          check: studentmanager.students[index].choosen!,
                          myfnc: () {
                            studentmanager.students[index].choosen =
                                !studentmanager.students[index].choosen!;
                            setState(() {});
                          },
                          tapFnc: () => _tapFnc(studentmanager.students[index],
                              studentmanager.students[index].id.toString())),
                    );
                  },
                );
              }));
  }
}

class TABLE_ROW extends StatelessWidget {
  const TABLE_ROW({
    Key? key,
    required this.size,
    this.check = false,
    required this.name,
    required this.id,
    required this.mobile,
    required this.myfnc,
    required this.tapFnc,
    required this.callfnc,
  }) : super(key: key);
  final size;
  final bool check;
  final String name;
  final String id;
  final String mobile;
  final VoidCallback myfnc;
  final VoidCallback tapFnc;
  final VoidCallback callfnc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.5),
      height: 30,
      width: double.infinity,
      child: Row(
        children: [
          Spacer(),
          Round_check_box(
            height: 30,
            width: size.width / 8,
            check: check,
            fnc: myfnc,
          ),
          InkWell(
              onTap: tapFnc,
              child: CELL(height: 30, width: size.width / 3, text: name)),
          CELL(height: 30, width: size.width / 6, text: id),
          CELL(height: 30, width: size.width / 5, text: mobile),
          InkWell(
              onTap: callfnc,
              child: Phone_Icon(height: 30, width: size.width / 7)),
          Spacer(),
        ],
      ),
    );
  }
}

class CELL extends StatelessWidget {
  const CELL({
    Key? key,
    required this.width,
    required this.height,
    required this.text,
  }) : super(key: key);
  final double width;
  final double height;
  final text;
  @override
  Widget build(BuildContext context) {
    const textStyle =
        TextStyle(fontSize: 15, fontFamily: 'AraHamah1964B-light');
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
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      )),
    );
  }
}

class CELL_Checkbox extends StatelessWidget {
  const CELL_Checkbox({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      child: Center(
        child: Checkbox(
          onChanged: (newval) {},
          value: false,
        ),
      ),
    );
  }
}

class Phone_Icon extends StatelessWidget {
  const Phone_Icon({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(border: Border.all(width: 1), color: Colors.green),
      child: Center(
        child: Icon(
          Icons.phone_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

// class Round_CheckBox extends StatefulWidget {
//   const Round_CheckBox(
//       {Key? key,
//       required this.width,
//       required this.height,
//       required this.check})
//       : super(key: key);

//   @override
//   _Round_CheckBoxState createState() => _Round_CheckBoxState();
//   final double width;
//   final double height;
//   final bool check;
// }

// class _Round_CheckBoxState extends State<Round_CheckBox> {
//   bool _value = widget.check;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _value = !_value;
//         });
//       },
//       child: Container(
//         width: widget.width,
//         height: widget.height,
//         decoration: BoxDecoration(border: Border.all(width: 1)),
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: _value ? Colors.orange[300] : Colors.orange[100],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Round_check_box extends StatelessWidget {
  const Round_check_box({
    Key? key,
    required this.width,
    required this.height,
    required this.check,
    required this.fnc,
  }) : super(key: key);

  final double width;
  final double height;
  final bool check;
  final VoidCallback fnc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fnc,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: check ? Colors.orange[300] : Colors.orange[100],
          ),
        ),
      ),
    );
  }
}
