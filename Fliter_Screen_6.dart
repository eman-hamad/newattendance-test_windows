// import 'package:attendance/constants.dart';
// import 'package:attendance/managers/group_manager.dart';
// import 'package:attendance/navigation/screens.dart';
// import 'package:attendance/screens/Filter_screen.dart/components/filters_top.dart';
// import 'package:attendance/screens/Filter_screen.dart/components/search_top.dart';
// import 'package:attendance/screens/Home/components/choices.dart';
// import 'package:attendance/screens/Students/components/Students_Top_Page.dart';
// import 'package:attendance/screens/show_group_presence/show_Presence.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Filter_Screen_6 extends StatelessWidget {
//   static MaterialPage page() {
//     return MaterialPage(
//       name: Attendance_Screens.data_students,
//       key: ValueKey(Attendance_Screens.data_students),
//       child: const Filter_Screen_6(),
//     );
//   }

//   const Filter_Screen_6({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: kbackgroundColor2,
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Search_top(size: size),
//               Filters_top(size: size),
//               Tabel_here(
//                 size: size,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Tabel_here extends StatefulWidget {
//   Tabel_here({Key? key, required this.size}) : super(key: key);
//   Size size;

//   @override
//   _Tabel_hereState createState() => _Tabel_hereState();
// }

// class _Tabel_hereState extends State<Tabel_here> {
//   //Color mycolor = kbuttonColor2;
//   var i = 0;
//   double width = 90;
//   bool is_clicked = false;
//   bool is_clicked_absence = false;
//   int _selectedIndex = 0;
//   int counter = 0;
//   var list__index = [];
//   _onSelected(int index) {
//     setState(() => _selectedIndex = index);
//   }

//   int _selectedIndexAbsence = 0;

//   _onSelected_absence(int index) {
//     setState(() => _selectedIndexAbsence = index);
//   }

//    existing (int selected){
    
//     for(i in list__index){
//      if( selected == i){
//        return 1 ;
//      }
//      return 0;
//       }
//   }

//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(Duration.zero, () async {
//       //  Provider.of<SubjectManager>(context, listen: false).resetlist();
//       //try {
//       await Provider.of<GroupManager>(context, listen: false)
//           .get_group_students(Choices.my_group)
//           .then((value) => {
//                 // print('valueeeeeeeeeeeeeee');
//                 // print(value);
//               });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: widget.size.height * .73,
//         // color: Colors.red,
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) =>
//               Container(
//             width: double.infinity,
//             // height: MediaQuery.of(context).size.height * .5,
//             child: SingleChildScrollView(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: widget.size.width * .3,
//                           // height: size.height,
//                           decoration: BoxDecoration(
//                               // color: Colors.red,
//                               ),
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: widget.size.width * .3,
//                                 height: widget.size.height * .25,
//                                 child: Center(
//                                   child: Container(
//                                     height: 30,
//                                     width: 60,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.grey),
//                                       color: kbackgroundColor3,
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         'تفعيل',
//                                         style:
//                                             TextStyle(fontFamily: 'GE-light'),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   // border: Border.all(color: Colors.black),
//                                   border: Border(
//                                     top: BorderSide.none,
//                                     right: BorderSide.none,
//                                     left: BorderSide(color: Colors.grey),
//                                   ),
//                                 ),
//                               ),
//                               Column(children: [
//                                 buildcellHead('اليوم'),
//                                 buildcellHead('التاريخ'),
//                                 buildcellHead('الاسم  |  الحصه'),
//                                 buildname(widget.size, 'سامح الصقار'),
//                                 // buildname(size, 'محمد احمد '),
//                                 // buildname(size, ' احمد محمد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),
//                                 // buildname(size, 'احمد سعيد'),

//                                 //   Container(
//                                 // // color: kbackgroundColor2,
//                                 // child: Consumer<GroupManager>(
//                                 //   builder: (builder, appmgr, child) => appmgr.group_students
//                                 //               .isEmpty
//                                 //           //     ||
//                                 //           // _isLoading
//                                 //       ? Padding(
//                                 //           padding: const EdgeInsets.all(20.0),
//                                 //           child: Text(
//                                 //             'لا يوجد طلاب',
//                                 //             //  حضرو الحصه',
//                                 //             style: TextStyle(fontFamily: 'GE-Bold'),
//                                 //           ),
//                                 //         )
//                                 //       : ListView.separated(
//                                 //           separatorBuilder:
//                                 //               (BuildContext ctxt, int Index) => Padding(
//                                 //                     padding: const EdgeInsets.symmetric(
//                                 //                         vertical: 15),
//                                 //                     child: Divider(
//                                 //                       color: Colors.black,
//                                 //                       height: 3,
//                                 //                       //thickness: 3,
//                                 //                     ),
//                                 //                   ),
//                                 //           // controller: _sc,
//                                 //           itemCount: appmgr.group_students.length,
//                                 //           itemBuilder: (BuildContext ctxt, int Index) {
//                                 //             return buildname(widget.size, appmgr.group_students[Index].students![Index].name!
//                                 //             );
//                                 //           }
//                                 //       )
//                                 // )
//                                 //           )
//                               ]),
//                             ],
//                           ),
//                         ),
//                       ]),
//                   Flexible(
//                     child: Container(
//                       // color: Colors.blue,
//                       //asdasdasdasdasdasd
//                       height: 26 * 40,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Expanded(
//                               child: Consumer<GroupManager>(
//                             builder: (builder, appmgr, child) => appmgr
//                                     .group_students.isEmpty
//                                 //     ||
//                                 // _isLoading
//                                 ? Padding(
//                                     padding: const EdgeInsets.all(20.0),
//                                     child: Text(
//                                       'لا يوجد حصص  ',
//                                       //  حضرو الحصه',
//                                       style: TextStyle(fontFamily: 'GE-Bold'),
//                                     ),
//                                   )
//                                 : ListView.builder(
//                                     shrinkWrap: true,
//                                     itemCount: appmgr.group_students.length,
//                                     scrollDirection: Axis.horizontal,
//                                     itemBuilder: (context, index) {
//                                       counter = index;
//                                       list__index.add(index);

//                                       //_onSelected(index);
//                                       return Container(
//                                         decoration: BoxDecoration(
//                                             // color: Colors.amber,
//                                             ),
//                                         child: Column(
//                                           children: [
//                                             buildfilter(
//                                                 '80-90',
//                                                 kbackgroundColor3,
//                                                 'AraHamah1964R-Bold'),
//                                             buildfilter('درجات',
//                                                 kbackgroundColor1, 'GE-light'),
//                                             buildfilter('تعويضات',
//                                                 kbuttonColor3, 'GE-light'),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 _onSelected_absence(index);
//                                                 print('indexxxxxxxxxxx');
//                                                 print(index);
//                                                 print('_selectedIndexXXX');
//                                                 print(_selectedIndex);
//                                                 for (i in list__index) {
//                                                   if (_selectedIndexAbsence ==
//                                                       i) {
//                                                     setState(() {
//                                                       is_clicked_absence =
//                                                           true;
//                                                       i;
//                                                       // mycolor = Colors.red;
//                                                       _selectedIndexAbsence;
//                                                     });
//                                                   }
//                                                 }
//                                               },
//                                               child: buildfilter(
//                                                   'غياب',
//                                                 existing(_selectedIndexAbsence)==1
//                                                           //  &&
//                                                           //         _selectedIndex !=
//                                                           //             null
//                                                           &&
//                                                           is_clicked_absence ==
//                                                               true
//                                                       ? Colors.red
//                                                       : kbackgroundColor3,
//                                                   'GE-light'),
//                                             ),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 _onSelected(index);
//                                                 print('indexxxxxxxxxxx');
//                                                 print(index);
//                                                 print('_selectedIndexXXX');
//                                                 print(_selectedIndex);

//                                                 if (_selectedIndex == index) {
//                                                   setState(() {
//                                                     is_clicked = !is_clicked;
//                                                     // mycolor = Colors.red;
//                                                     _selectedIndex;
//                                                   });
//                                                 }
//                                               },
//                                               child: buildfilter(
//                                                   'حضور',
//                                                   _selectedIndex == index
//                                                           //  &&
//                                                           //         _selectedIndex !=
//                                                           //             null
//                                                           &&
//                                                           is_clicked == true
//                                                       ? Colors.yellow
//                                                       : kbuttonColor2,
//                                                   'GE-light'),
//                                             ),
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: Colors.black),
//                                               ),
//                                               width: width,
//                                               height: 35,
//                                               child: Center(
//                                                 child: Text(
//                                                   'السبت',
//                                                   style: TextStyle(
//                                                       fontFamily: 'GE-medium'),
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: Colors.black),
//                                               ),
//                                               width: width,
//                                               height: 35,
//                                               child: Center(
//                                                 child: Text(
//                                                   appmgr.group_students[index]
//                                                       .date!,
//                                                   style: TextStyle(
//                                                       fontFamily:
//                                                           'AraHamah1964R-Bold'),
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: Colors.black),
//                                               ),
//                                               width: width,
//                                               height: 35,
//                                               child: Center(
//                                                 child: Text(
//                                                   // 'حصه + '${Index+1}'',
//                                                   //'حصة ',
//                                                   'حصة  ${++counter} ',
//                                                   style: TextStyle(
//                                                       fontFamily: 'GE-medium'),
//                                                 ),
//                                               ),
//                                             ),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                             build_icon(40),
//                                           ],
//                                         ),
//                                       );
//                                     }),
//                           )),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   Container buildfilter(String name, Color color, String style) {
//     return Container(
//       decoration: BoxDecoration(
//         color: color,
//         border: Border.all(color: Colors.grey),
//       ),
//       width: width,
//       height: widget.size.height * .25 / 5,
//       child: Center(
//         child: Text(
//           name,
//           style: TextStyle(fontFamily: style),
//         ),
//       ),
//     );
//   }

//   Container buildcellHead(String name) {
//     return Container(
//       width: widget.size.width * .3,
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

//   List<Widget> _buildCells(int count) {
//     return List.generate(
//       count,
//       (index) => Container(
//         alignment: Alignment.center,
//         width: 120.0,
//         height: 60.0,
//         color: Colors.white,
//         margin: EdgeInsets.all(4.0),
//         child: Text('hi'),
//       ),
//     );
//   }

//   List<Widget> _buildRows(int count) {
//     return List.generate(
//       count,
//       (index) => Row(
//         children: _buildCells(10),
//       ),
//     );
//   }

//   Container buildname(Size size, String name) {
//     return Container(
//       width: size.width * .3,
//       height: 40,
//       decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//       child: Center(
//         child: Text(
//           name,
//           style: TextStyle(fontFamily: 'GE-light'),
//         ),
//       ),
//     );
//   }

//   Container build_icon(double height) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.black),
//       ),
//       width: width,
//       height: height,
//       child: Center(
//         child: Icon(
//           Icons.done,
//           color: Colors.green,
//         ),
//       ),
//     );
//   }
// }
