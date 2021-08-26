import 'dart:async';

import 'package:attendance/constants.dart';
import 'package:attendance/helper/httpexception.dart';
import 'package:attendance/managers/group_manager.dart';
import 'package:attendance/navigation/screens.dart';
import 'package:attendance/screens/Filter_screen.dart/components/filters_top.dart';
import 'package:attendance/screens/Filter_screen.dart/components/search_top.dart';
import 'package:attendance/screens/Home/components/choices.dart';
import 'package:attendance/screens/Students/components/Students_Top_Page.dart';
import 'package:attendance/screens/show_group_presence/show_Presence.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

bool show_student = false;
Color my_color = Colors.yellow;
bool added = false;
double width = 90;
bool _isLoading = false;
int counter = 0;
var my_lesson_id = [];
var my_student_absence = [];
String absence_text = 'حالة الحضور';
bool finished = false;
bool is_finished = false;

class Filter_Screen_6 extends StatelessWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Attendance_Screens.data_students,
      key: ValueKey(Attendance_Screens.data_students),
      child: const Filter_Screen_6(),
    );
  }

  const Filter_Screen_6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kbackgroundColor2,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Search_top(size: size),
             
              Filters_top(size: size),
              //  SizedBox(
              //   height: 8,
              // ),
              Tabel_here(
                size: size,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tabel_here extends StatefulWidget {
  Tabel_here({Key? key, required this.size}) : super(key: key);
  Size size;

  @override
  _Tabel_hereState createState() => _Tabel_hereState();
}

class _Tabel_hereState extends State<Tabel_here> {
  FocusNode fnode = FocusNode();
  // var _isLoading = false;
  void _submit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      setState(() {
        Group_Id;
      });
      await Provider.of<GroupManager>(context, listen: false)
          .add_compare(my_lesson_id, my_student_absence, Choices.my_group)
          .then((_) {
            result = '';
            setState(() {
              // sent = true;
            });
          })
          .then((value) => setState(() {
                _isLoading = false;
              }))
          .then(
            (_) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green[300],
                content: Text(
                  'تمت المقارنة',
                  style: TextStyle(fontFamily: 'GE-medium'),
                ),
                duration: Duration(seconds: 3),
              ),
            ),
          );
    } on HttpException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green[300],
          content: Text(
            'لا يوجد طلاب',
            style: TextStyle(fontFamily: 'GE-medium'),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[400],
          content: Text(
            'لا يوجد طلاب',
            style: TextStyle(fontFamily: 'GE-medium'),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  Color mycolor = kbuttonColor2;
  var i = 0;

  bool is_clicked = false;
  bool is_clicked_absence = false;
  int _selectedIndex = 0;
  int counter = 0;
  var list__index = [];
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  int _selectedIndexAbsence = 0;

  _onSelected_absence(int index) {
    setState(() => _selectedIndexAbsence = index);
  }

  //existing(int selected) {
  //   for (i in list__index) {
  //     if (selected == i) {
  //       return 1;
  //     }
  //     return 0;
  //   }
  // }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      //  Provider.of<SubjectManager>(context, listen: false).resetlist();
      //try {
      await Provider.of<GroupManager>(context, listen: false)
          .get_group_students(Choices.my_group)
          .then((value) => {
                // print('valueeeeeeeeeeeeeee');
                // print(value);
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: widget.size.height * .73,
        // color: Colors.red,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              Container(
            width: double.infinity,
            // height: MediaQuery.of(context).size.height * .5,
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: widget.size.width * .3,
                          // height: size.height,
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              ),
                          child: Column(
                            children: [
                              Container(
                                width: widget.size.width * .3,
                                height: widget.size.height * .25,
                                child: Center(
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: kbackgroundColor3,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (my_lesson_id.isNotEmpty &&
                                                added == true) {
                                              _submit();

                                              show_student = true;
                                              finished = true;
                                              print(
                                                  'before my  my_lesson_iddddddddddddd');
                                              print(my_lesson_id);
                                              my_lesson_id.clear();
                                              my_student_absence.clear();

                                              // is_clicked = false;
                                              // is_clicked_absence = false;
                                              setState(() {
                                                finished = true;
                                                is_finished = true;
                                                //             my_color= kbuttonColor2;
                                                //               is_clicked = false;
                                              });

                                              print(
                                                  'after my  my_lesson_iddddddddddddd');
                                              print(my_lesson_id);
                                              print(
                                                  'my_student_absenceeeeeeeeeee');

                                              print(my_student_absence);
                                            }
                                            print(
                                                'no  my_lesson_iddddddddddddd');
                                            print(my_lesson_id);

                                            //  print('nooooooooooooo');
                                          });
                                        },
                                        child: Text(
                                          'تفعيل',
                                          style:
                                              TextStyle(fontFamily: 'GE-light'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.black),
                                  border: Border(
                                    top: BorderSide.none,
                                    right: BorderSide.none,
                                    left: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Column(children: [
                                buildcellHead('اليوم'),
                                buildcellHead('التاريخ'),
                                buildcellHead('الاسم  |  الحصه'),
                                // buildname(widget.size, 'سامح الصقار'),
                                // buildname(size, 'محمد احمد '),
                                // buildname(size, ' احمد محمد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),
                                // buildname(size, 'احمد سعيد'),

                                Container(
                                    // color: kbackgroundColor2,
                                    child: Consumer<GroupManager>(
                                        builder: (builder, appmgr, child) => appmgr
                                                .students_compare!.isEmpty
                                            //     ||
                                            // _isLoading
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text(
                                                  'لا يوجد طلاب',
                                                  //  حضرو الحصه',
                                                  style: TextStyle(
                                                      fontFamily: 'GE-Bold'),
                                                ),
                                              )
                                            :
                                            //  ListView.separated(
                                            //     separatorBuilder: (BuildContext
                                            //                 ctxt,
                                            //             int Index) =>
                                            //         Padding(
                                            //           padding:
                                            //               const EdgeInsets
                                            //                       .symmetric(
                                            //                   vertical: 15),
                                            //           child: Divider(
                                            //             color: Colors.black,
                                            //             height: 3,
                                            //             //thickness: 3,
                                            //           ),
                                            //         ),
                                            //     // controller: _sc,
                                            //     itemCount: appmgr
                                            //         .students_compare!.length,
                                            //     itemBuilder: (BuildContext ctxt,
                                            //             int Index) =>
                                            //         show_student == true
                                            //             ?

                                            Column(
                                                children: [
                                                  for (var i = 0;
                                                      i <
                                                          appmgr
                                                              .students_compare!
                                                              .length;
                                                      i++)
                                                    buildname(
                                                        widget.size,
                                                        appmgr
                                                            .students_compare![
                                                                i]
                                                            .name!)
                                                ],
                                              )))
                                //             : SizedBox())))
                              ]),
                            ],
                          ),
                        ),
                      ]),
                  Flexible(
                    child: Container(
                      // color: Colors.blue,
                      //asdasdasdasdasdasd
                      height: 26 * 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(child: Consumer<GroupManager>(
                              builder: (builder, appmgr, child) {
                            //=>

                            // my_lesson_id.add(appmgr.group_students[index].id);
                            // print('my_lesson_idddddddddd');
                            // print(my_lesson_id);
                            // added = true;

                            if (appmgr.group_students.isEmpty) {
                              //     ||
                              // _isLoading
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'لا يوجد حصص  ',
                                  //  حضرو الحصه',
                                  style: TextStyle(fontFamily: 'GE-Bold'),
                                ),
                              );
                            }
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: appmgr.group_students.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  counter = index;
                                  list__index.add(index);

                                  //_onSelected(index);
                                  return MyListItem(index, appmgr);
                                  // return Container(
                                  //   decoration: BoxDecoration(
                                  //       // color: Colors.amber,
                                  //       ),
                                  //   child: Column(
                                  //     children: [
                                  //       buildfilter(
                                  //           '80-90',
                                  //           kbackgroundColor3,
                                  //           'AraHamah1964R-Bold'),
                                  //       buildfilter('درجات',
                                  //           kbackgroundColor1, 'GE-light'),
                                  //       buildfilter('تعويضات',
                                  //           kbuttonColor3, 'GE-light'),
                                  //       // GestureDetector(
                                  //       //   onTap: () {
                                  //       //     _onSelected_absence(index);
                                  //       //     print('indexxxxxxxxxxx');
                                  //       //     print(index);
                                  //       //     print('_selectedIndexXXX');
                                  //       //     print(_selectedIndex);
                                  //       //     for (i in list__index) {
                                  //       //       if (_selectedIndexAbsence ==
                                  //       //           i) {
                                  //       //         setState(() {
                                  //       //           is_clicked_absence =
                                  //       //               true;
                                  //       //           i;
                                  //       //           // mycolor = Colors.red;
                                  //       //           _selectedIndexAbsence;
                                  //       //         });
                                  //       //       }
                                  //       //     }
                                  //       //   },
                                  //       //   child: buildfilter(
                                  //       //       'غياب',
                                  //       //     existing(_selectedIndexAbsence)==
                                  //       //               //  &&
                                  //       //               //         _selectedIndex !=
                                  //       //               //             null
                                  //       //               &&
                                  //       //               is_clicked_absence ==
                                  //       //                   true
                                  //       //           ? Colors.red
                                  //       //           : kbackgroundColor3,
                                  //       //       'GE-light'),
                                  //       // ),
                                  //       GestureDetector(
                                  //         onTap: () {
                                  //           _onSelected(index);
                                  //           print('indexxxxxxxxxxx');
                                  //           print(index);
                                  //           print('_selectedIndexXXX');
                                  //           print(_selectedIndex);

                                  //           if (_selectedIndex == index) {
                                  //             setState(() {
                                  //               is_clicked = !is_clicked;
                                  //               // mycolor = Colors.red;
                                  //               _selectedIndex;
                                  //             });
                                  //           }
                                  //         },
                                  //         child: buildfilter(
                                  //             _selectedIndex == index
                                  //                     //  &&
                                  //                     //         _selectedIndex !=
                                  //                     //             null
                                  //                     &&
                                  //                     is_clicked == true
                                  //                 ? 'حضور'
                                  //                 : 'غياب',
                                  //             _selectedIndex == index
                                  //                     //  &&
                                  //                     //         _selectedIndex !=
                                  //                     //             null
                                  //                     &&
                                  //                     is_clicked == true
                                  //                 ? Colors.yellow
                                  //                 : Colors.red,
                                  //             //kbuttonColor2,
                                  //             'GE-light'),
                                  //       ),
                                  //       Container(
                                  //         decoration: BoxDecoration(
                                  //           border: Border.all(
                                  //               color: Colors.black),
                                  //         ),
                                  //         width: width,
                                  //         height: 35,
                                  //         child: Center(
                                  //           child: Text(
                                  //             'السبت',
                                  //             style: TextStyle(
                                  //                 fontFamily: 'GE-medium'),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         decoration: BoxDecoration(
                                  //           border: Border.all(
                                  //               color: Colors.black),
                                  //         ),
                                  //         width: width,
                                  //         height: 35,
                                  //         child: Center(
                                  //           child: Text(
                                  //             appmgr.group_students[index]
                                  //                 .date!,
                                  //             style: TextStyle(
                                  //                 fontFamily:
                                  //                     'AraHamah1964R-Bold'),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         decoration: BoxDecoration(
                                  //           border: Border.all(
                                  //               color: Colors.black),
                                  //         ),
                                  //         width: width,
                                  //         height: 35,
                                  //         child: Center(
                                  //           child: Text(
                                  //             // 'حصه + '${Index+1}'',
                                  //             //'حصة ',
                                  //             'حصة  ${++counter} ',
                                  //             style: TextStyle(
                                  //                 fontFamily: 'GE-medium'),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //       build_icon(40),
                                  //     ],
                                  //   ),
                                  // );
                                });
                          })),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Container buildfilter(String name, Color color, String style) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.grey),
      ),
      width: width,
      height: widget.size.height * .25 / 5,
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontFamily: style),
        ),
      ),
    );
  }

  Container buildcellHead(String name) {
    return Container(
      width: widget.size.width * .3,
      height: 35,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontFamily: 'GE-medium'),
        ),
      ),
    );
  }

  List<Widget> _buildCells(int count) {
    return List.generate(
      count,
      (index) => Container(
        alignment: Alignment.center,
        width: 120.0,
        height: 60.0,
        color: Colors.white,
        margin: EdgeInsets.all(4.0),
        child: Text('hi'),
      ),
    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
      count,
      (index) => Row(
        children: _buildCells(10),
      ),
    );
  }

  Container buildname(Size size, String name) {
    return Container(
      width: size.width * .3,
      height: 40,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontFamily: 'GE-light'),
        ),
      ),
    );
  }

  Container build_icon(double height) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      width: width,
      height: height,
      child: Center(
        child: Icon(
          Icons.done,
          color: Colors.green,
        ),
      ),
    );
  }
}

////////////////////////

class MyListItem extends StatefulWidget {
  GroupManager appmgr;
  @required
  final int index;

  MyListItem(this.index, this.appmgr);
  @override
  _MyListItemState createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem> {
  String dateFormat = '';
  _getDay(myDate) {
    DateTime date = DateTime.parse(myDate);

    dateFormat = DateFormat('EEEE').format(date);

    switch (dateFormat) {
      case 'Saturday':
        {
          dateFormat = 'السبت';
        }
        break;

      case 'Sunday':
        {
          dateFormat = 'اللأحد';
        }
        break;

      case 'Monday':
        {
          dateFormat = 'الاثنين';
        }
        break;

      case 'Tuesday':
        {
          dateFormat = 'الثلاثاء';
        }
        break;

      case 'Wednesday':
        {
          dateFormat = 'الاربعاء';
        }
        break;

      case 'Thursday':
        {
          dateFormat = 'الخميس';
        }
        break;

      case 'Friday':
        {
          dateFormat = 'الجمعة';
        }
        break;
    }
  }

  //final size = MediaQuery.of(context).size;
  var i = 0;
  double width = 90;
  bool is_clicked = false;
  bool is_clicked_absence = false;
  int _selectedIndex = 0;

  var list__index = [];
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  // var myColors = [Colors.red, Colors.yellow, Colors.green];
  // _changeColor(mycolor) {
  //   setState(() {
  //     if (mycolor == myColors[0]) {
  //       mycolor == Colors.yellow;
  //     }
  //     else if(mycolor == myColors[1]){
  //       mycolor == Colors.red;
  //     }
  //     else
  //     mycolor == Colors.green;
  //   });
  // }
  bool _enabled = true;
  bool _press_enabled = true;
// void _onTap () {
//   setState(() {
// _enabled = false;

//   //Timer(Duration(seconds: 1), () => setState(() => _enabled = true
//   });

// }

  int _selectedIndexAbsence = 0;

  _onSelected_absence(int index) {
    setState(() => _selectedIndexAbsence = index);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      counter;
    });
    //final size = MediaQuery.of(context).size;
    _getDay(widget.appmgr.group_students[widget.index].date);
    return Container(
      decoration: BoxDecoration(
          // color: Colors.amber,
          ),
      child: Column(
        children: [
          buildfilter('80-90', kbackgroundColor3, 'AraHamah1964R-Bold'),
          buildfilter('درجات', kbackgroundColor1, 'GE-light'),
          buildfilter('تعويضات', kbuttonColor3, 'GE-light'),
          // GestureDetector(
          //   onTap: () {
          //     _onSelected_absence(widget.index);
          //     print('indexxxxxxxxxxx');
          //     print(widget.index);
          //     print('_selectedIndexXXX');
          //     print(_selectedIndex);
          //     for (i in list__index) {
          //       if (_selectedIndexAbsence ==
          //           i) {
          //         setState(() {
          //           is_clicked_absence =
          //               true;
          //           i;
          //           // mycolor = Colors.red;
          //           _selectedIndexAbsence;
          //         });
          //       }
          //     }
          //   },
          //   child: buildfilter(
          //       'غياب',
          //     // /existing(_selectedIndexAbsence)==
          //     //           //  &&
          //     //           //         _selectedIndex !=
          //     //           //             null
          //     //           &&
          //               is_clicked_absence ==
          //                   true
          //           ? Colors.red
          //           : kbackgroundColor3,
          //       'GE-light'),
          // ),

          GestureDetector(
            onTap: _enabled == false
                ? null
                : () {
                    // _onTap();
                   _onSelected(widget.index);
                    print('indexxxxxxxxxxx');
                    print(widget.index);
                    print('_selectedIndexXXX');
                    print(_selectedIndex);

                    if (_selectedIndex == widget.index) {
                      setState(() {
                        is_clicked_absence = !is_clicked_absence;
                        // mycolor = Colors.red;
                        _selectedIndex;
                        if (!my_lesson_id.contains(
                            widget.appmgr.group_students[widget.index].id)) {
                          my_lesson_id.add(
                              widget.appmgr.group_students[widget.index].id);
                          added = true;
                          print('my_lesson_idddddddddddddddddddd');
                          print(my_lesson_id);
                        }
                        if (is_clicked_absence == true) {
                          setState(() {
                            _press_enabled = false;
                            is_finished = false;
                          });
                          my_student_absence.add('absence');
                          print('absence my_student_absenceeeeeeeeeee');
                          print(my_student_absence);
                        } else {
                          setState(() {
                            _press_enabled = true;
                            
                            my_student_absence.remove('absence');
                            my_lesson_id.remove(
                                widget.appmgr.group_students[widget.index].id);
                          });
                        }
                        // else if (is_clicked_absence == false) {
                        //   my_student_absence.add('absence');
                        //   print('absence my_student_absenceeeeeeeeeee');
                        //   print(my_student_absence);
                        // }
                      });
                    }
                  },
            child: buildfilter(
                // _selectedIndex == widget.index
                //         //  &&
                //         //         _selectedIndex !=
                //         //             null
                //         &&
                //         is_clicked == true
                //?
                //'حضور',
                'غياب',
                _selectedIndex == widget.index
                        //  &&
                        //         _selectedIndex !=
                        //
                        // &&
                        // _changeColor()
                        &&
                        is_clicked_absence == true &&
                        is_finished == false
                    //? Colors.yellow
                    ? Colors.red
                    : kbackgroundColor3,
                'GE-light'),
          ),

          GestureDetector(
            onTap: _press_enabled == false
                ? null
                : () {
                    _onSelected(widget.index);
                    print('indexxxxxxxxxxx');
                    print(widget.index);
                    print('_selectedIndexXXX');
                    print(_selectedIndex);

                    if (_selectedIndex == widget.index) {
                      setState(() {
                        is_clicked = !is_clicked;
                        // mycolor = Colors.red;
                        _selectedIndex;
                        if (!my_lesson_id.contains(
                            widget.appmgr.group_students[widget.index].id)) {
                          my_lesson_id.add(
                              widget.appmgr.group_students[widget.index].id);
                          added = true;
                          print('my_lesson_idddddddddddddddddddd');
                          print(my_lesson_id);
                        }
                        if (is_clicked == true) {
                          setState(() {
                            finished = false;
                            _enabled = false;
                          });
                          my_student_absence.add('attend');
                          print('attend my_student_absenceeeeeeeeeeeeeeeee');
                          print(my_student_absence);
                        } else {
                          setState(() {
                            _enabled = true;
                            my_student_absence.remove('attend');
                            my_lesson_id.remove(
                                widget.appmgr.group_students[widget.index].id);
                          });
                        }
                        // else if (is_clicked == false) {
                        //   my_student_absence.add('absence');
                        //   print('absence my_student_absenceeeeeeeeeee');
                        //   print(my_student_absence);
                        // }
                      });
                    }
                  },
            child: buildfilter(
                // _selectedIndex == widget.index
                //         //  &&
                //         //         _selectedIndex !=
                //         //             null
                //         &&
                //         is_clicked == true
                //?
                'حضور',
                // : 'غياب',
                _selectedIndex == widget.index
                        //  &&
                        //         _selectedIndex !=
                        //
                        // &&
                        // _changeColor()
                        &&
                        is_clicked == true &&
                        finished == false
                    ? my_color
                    // : Colors.red,
                    : kbuttonColor2,
                'GE-light'),
          ),

//  GestureDetector(
//             onTap: () {
//               _onSelected(widget.index);
//               print('indexxxxxxxxxxx');
//               print(widget.index);
//               print('_selectedIndexXXX');
//               print(_selectedIndex);

//               if (_selectedIndex == widget.index) {
//                 setState(() {
//                   is_clicked = !is_clicked;
//                   // mycolor = Colors.red;
//                   _selectedIndex;
//                   if (!my_lesson_id.contains(
//                       widget.appmgr.group_students[widget.index].id)) {
//                     my_lesson_id
//                         .add(widget.appmgr.group_students[widget.index].id);
//                     added = true;
//                     print('my_lesson_idddddddddddddddddddd');
//                     print(my_lesson_id);
//                   }
//                   if (is_clicked == true) {
//                     my_student_absence.add('attend');
//                     print('attend my_student_absenceeeeeeeeeeeeeeeee');
//                     print(my_student_absence);
//                   } else if (is_clicked == false) {
//                     my_student_absence.add('absence');
//                     print('absence my_student_absenceeeeeeeeeee');
//                     print(my_student_absence);
//                   }
//                 });
//               }
//             },
//             child: buildfilter(
//                 _selectedIndex == widget.index
//                         //  &&
//                         //         _selectedIndex !=
//                         //             null
//                         &&
//                         is_clicked == true
//                     ? 'حضور'
//                     : 'غياب',
//                 _selectedIndex == widget.index
//                         //  &&
//                         //         _selectedIndex !=
//                         //
//                        // &&
//                        // _changeColor()
//                         &&
//                         is_clicked == true
//                     ? Colors.yellow
//                     : Colors.red,
//                 //kbuttonColor2,
//                 'GE-light'),
//           ),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            width: width,
            height: 35,
            child: Center(
              child: Text(
                // 'السبت',
                dateFormat,
                // widget.appmgr.group_students[widget.index].date!
                style: TextStyle(fontFamily: 'GE-medium'),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            width: width,
            height: 35,
            child: Center(
              child: Text(
                widget.appmgr.group_students[widget.index].date!,
                style: TextStyle(fontFamily: 'AraHamah1964R-Bold'),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            width: width,
            height: 35,
            child: Center(
              child: Text(
                // 'حصه + '${Index+1}'',
                //'حصة ',
                'حصة  ${widget.index + 1} ',
                style: TextStyle(fontFamily: 'GE-medium'),
              ),
            ),
          ),
          for (var i = 0; i < widget.appmgr.students_compare!.length; i++)
            build_icon(40, is_clicked ? true : false),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
          // build_icon(40),
        ],
      ),
    );
  }
}
//                                     final size =
// MediaQuery.of(context).size;

Container buildfilter(String name, Color color, String style) {
  //final size = MediaQuery.of(context).size;
  return Container(
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: Colors.grey),
    ),
    width: width,
    height: 35,
    //size.height * .25 / 5,
    child: Center(
      child: Text(
        name,
        style: TextStyle(fontFamily: style),
      ),
    ),
  );
}

//   Container buildcellHead(String name) {
// final size = MediaQuery.of(context).size;
//     return Container(
//       width: width,
//       //size.width * .3,
//       height: 35,
//       decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//       child: Center(
//         child: Text(
//           name,
//           style: TextStyle(fontFamily: 'GE-medium'),
//         ),
//       ),
//     );
//   }

List<Widget> _buildCells(int count) {
  return List.generate(
    count,
    (index) => Container(
      alignment: Alignment.center,
      width: 120.0,
      height: 60.0,
      color: Colors.white,
      margin: EdgeInsets.all(4.0),
      child: Text('hi'),
    ),
  );
}

List<Widget> _buildRows(int count) {
  return List.generate(
    count,
    (index) => Row(
      children: _buildCells(10),
    ),
  );
}

Container buildname(Size size, String name) {
  return Container(
    width: size.width * .3,
    height: 40,
    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    child: Center(
      child: Text(
        name,
        style: TextStyle(fontFamily: 'GE-light'),
      ),
    ),
  );
}

Container build_icon(double height, bool add) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black),
    ),
    width: width,
    height: height,
    child: Center(
      child: IconButton(
        onPressed: () {},
        icon: add == true ? Icon(Icons.done) : Icon(null),
        color: Colors.green,
      ),
    ),
  );
}
