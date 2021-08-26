// import 'package:attendance/screens/Students/components/Students_Top_Page.dart';
// import 'package:attendance/screens/degrees/components/Degrees_top.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_select/smart_select.dart';

// import '../../constants.dart';
// import 'package:attendance/screens/degrees/components/check_box.dart';

// import 'components/default_form_field.dart';

// get_list() {
//   List<KeyValueModel> datas = [
//     KeyValueModel(key: 'سامح الصقار', value: "Value 1"),
//     KeyValueModel(key: 'محمد أحمد', value: "Value 2"),
//     KeyValueModel(key: 'أكرم محمود', value: "Value 3"),
//     KeyValueModel(key: 'أحمد الصقار', value: "Value 4"),
//     KeyValueModel(key: 'محمود أحمد', value: "Value 5"),
//     KeyValueModel(key: 'صلاح أحمد', value: "Value 6"),
//   ];
//   return datas;
// }


// class KeyValueModel {
//   String key;
//   String? value;

//   KeyValueModel({required this.key, this.value});

//   @override
//   String toString() {
//     return key;
//   }
// }

//  KeyValueModel _selectedValue = KeyValueModel(key: "0", value: "value");


// // get_code() {
// //   List<KeyValueCode> code_data = [
// //     KeyValueCode(codekey: 'A12345', codevalue: "Value 1"),
// //     KeyValueCode(codekey: 'D22345',  codevalue: "Value 2"),
// //     KeyValueCode(codekey: 'C32345',  codevalue: "Value 3"),
// //     KeyValueCode(codekey: 'B42345',  codevalue: "Value 4"),
    
// //   ];
// //   return code_data;
// // }


// // class KeyValueCode {
// //   String codekey;
// //   String? codevalue;

// //   KeyValueCode({required this.codekey, this.codevalue});

// //   @override
// //   String toString() {
// //     return codekey;
// //   }
// // }

// //  KeyValueCode _selectedCode = KeyValueCode(codekey: "0", codevalue: "value");



// IconData icon = Icons.close;
// Color icon_color = Colors.red;

// class Degrees_Screen extends StatefulWidget {
//   Degrees_Screen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _Degrees_ScreenState createState() => _Degrees_ScreenState();
// }

// class _Degrees_ScreenState extends State<Degrees_Screen> {
//   bool pressed = false;
//   bool build_row = false;
//   Map<int, String> val = {};
//   List<CheckBox<int>> multiItem = [];
//   var buttonText = 'غياب';
//   Color color = Colors.red;
//   var scaffoldKey = GlobalKey<ScaffoldState>();

//   var formKey = GlobalKey<FormState>();
//   var attendenceController = TextEditingController();
//   var degreeController = TextEditingController();
//   var classController = TextEditingController();
//   bool isButtomSheetShown = false;

//   List listan = get_list();

 

//   final valuestopopulate = {
//     1: "سنتر الياسمين 2:30",
//     2: "سنتر الياسمين 9:30",
//     3: "سنتر الياسمين 10:30",
//     4: "سنتر الياسمين 5:30",
//     5: "سنتر الياسمين 3:00",
//   };
//   Map<int, String> value = {};
//   var new_val = [];
//   // String status = 'غياب';

//   Map<String, dynamic> _register_data = {
//     'name': null,
//     'class': null,
//   };

//   var element;
//   int index = 0;
//   bool pressattendence = false;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: kbackgroundColor2,
//         key: scaffoldKey,
//         body: Column(
//           children: [
//             Student_Top_Page(size: size),
//             // Degrees_top(),
//             Container(
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Column(
//                       children: [
//                         for (var i in new_val)

//                           // new_val.length > 0
//                           Text(
//                             "${i.toString()}",
//                             maxLines: 5,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )
//                         // : SizedBox()
//                       ],
//                     ),
//                     Spacer(),
//                     Column(
//                       children: [
//                         IconButton(
//                             icon: Icon(
//                               Icons.check,
//                               size: 60,
//                               color: Colors.green,
//                             ),
//                             onPressed: () {}),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               new_val.length;
//                             });
//                             // pressed ? SizedBox():buildNewTable();
//                             _showMultiSelect(context);
//                           },
//                           child: Container(
//                             alignment: Alignment.centerRight,
//                             padding: EdgeInsets.symmetric(horizontal: 10),
//                             height: 30,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(color: Colors.grey),
//                             ),
//                             child: Container(
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     "أضافة مجموعة",
//                                     style: TextStyle(fontFamily: 'GE-medium'),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           alignment: Alignment.centerRight,
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           height: 30,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(color: Colors.grey),
//                           ),
//                           child: Container(
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(
//                                   "كل المجموعات",
//                                   style: TextStyle(fontFamily: 'GE-medium'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 20),
//                 width: size.width * .8,
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: size.width * 0.9,
//                       // height: 55,
//                       child: Align(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               IconButton(
//                                 icon: Icon(
//                                   isButtomSheetShown ? Icons.edit : Icons.add,
//                                 ),
//                                 color: Colors.black,
//                                 onPressed: () {
//                                   setState(() {
//                                     isButtomSheetShown = !isButtomSheetShown;
//                                   });

//                                   setState(() {
//                                     build_row = !build_row;
//                                   });

//                                   if (isButtomSheetShown) {
//                                     var controller = scaffoldKey.currentState!
//                                             .showBottomSheet(
//                                       (context) => Container(
//                                         padding: EdgeInsets.all(20.0),
//                                         color: Colors.white,
//                                         child: Form(
//                                           key: formKey,
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Container(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .8,
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 20),
//                                                 height: 40,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                   border: Border.all(
//                                                       color: Colors.grey),
//                                                 ),
//                                                 child:
//                                                     DropdownButtonHideUnderline(
//                                                   child: DropdownButton(
//                                                     style: TextStyle(
//                                                         fontFamily: 'GE-medium',
//                                                         color: Colors.black),
//                                                     value:
//                                                         _register_data['class'],
//                                                     hint: Text('الحصة'),
//                                                     isExpanded: true,
//                                                     iconSize: 30,
//                                                     onChanged: (newval) {
//                                                       setState(() {
//                                                         _register_data[
//                                                                 'class'] =
//                                                             newval.toString();
//                                                       });
//                                                     },
//                                                     icon: Icon(Icons
//                                                         .keyboard_arrow_down),
//                                                     items: ['1', '2', '3', '4']
//                                                         .map((item) =>
//                                                             DropdownMenuItem(
//                                                               child: Text(item),
//                                                               value: item,
//                                                             ))
//                                                         .toList(),
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),

//                                               // Container(
//                                               //   alignment:
//                                               //       Alignment.centerRight,
//                                               //   width: MediaQuery.of(context)
//                                               //           .size
//                                               //           .width *
//                                               //       .8,
//                                               //   padding: EdgeInsets.symmetric(
//                                               //       horizontal: 20),
//                                               //   height: 40,
//                                               //   decoration: BoxDecoration(
//                                               //     borderRadius:
//                                               //         BorderRadius.circular(20),
//                                               //     border: Border.all(
//                                               //         color: Colors.grey),
//                                               //   ),
//                                               //   child: ElevatedButton(
//                                               //     child: Text(status),

//                                               //     onPressed: () {
//                                               //       // if (pressattendence ==
//                                               //       //     true) {
//                                               //       //   setState(() {
//                                               //       //     pressattendence =
//                                               //       //         !pressattendence;
//                                               //       //     // status = 'غياب';
//                                               //       //   });

//                                               //       //   print("true");
//                                               //       // } else {
//                                               //       //   setState(() {
//                                               //       //     pressattendence =
//                                               //       //         !pressattendence;
//                                               //       //     // status = 'حضور';
//                                               //       //   });
//                                               //       //   print("false");
//                                               //       // }

//                                               //       print("okkkkk");
//                                               //       setState(() {
//                                               //         // pressattendence =
//                                               //         //     !pressattendence;
//                                               //         status = 'غياب';
//                                               //       });
//                                               //     },
//                                               //     // width: MediaQuery.of(context)
//                                               //     //         .size
//                                               //     //         .width *
//                                               //     //     .8,
//                                               //     //     backgroundColor: ,
//                                               //   ),
//                                               // ),
//                                               //=======
//                                               Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     .8,
//                                                 height: 40,
//                                                 child: ElevatedButton(
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         buttonText = 'حضور';
//                                                         color = Colors.green;
//                                                         icon = Icons.check;
//                                                         icon_color =
//                                                             Colors.green;
//                                                       });
//                                                     },
//                                                     style: ButtonStyle(
//                                                       backgroundColor:
//                                                           MaterialStateProperty
//                                                               .all<Color>(
//                                                                   color),
//                                                     ),
//                                                     child: Text(buttonText)),
//                                               ),
//                                               //======
//                                               // GestureDetector(
//                                               //   onTap: () {
//                                               //     // color:
//                                               //     // Colors.accents;
//                                               //     print("okkkkk");
//                                               //     setState(() {
//                                               //       pressattendence =
//                                               //           !pressattendence;
//                                               //     });
//                                               //   },
//                                               //   child: defaultFormField(
//                                               //     // enable: true,
//                                               //     controller:
//                                               //         attendenceController,
//                                               //     type: TextInputType.text,

//                                               //     validate: (String value) {
//                                               //       if (value.isEmpty) {
//                                               //         return 'title must not be empty';
//                                               //       }

//                                               //       return null;
//                                               //     },
//                                               //     text: 'الحضور',
//                                               //     isClickable: true,
//                                               //     interact: true,
//                                               //     focus: FocusNode(),

//                                               //     prefix: Icons
//                                               //         .check_circle_outline,
//                                               //   ),
//                                               // ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                               defaultFormField(
//                                                 controller: degreeController,
//                                                 type: TextInputType.number,
//                                                 validate: (String value) {
//                                                   if (value.isEmpty) {
//                                                     return 'title must not be empty';
//                                                   }

//                                                   return null;
//                                                 },
//                                                 text: 'الدرجة',
//                                                 // enable:true,

//                                                 prefix:
//                                                     Icons.fact_check_rounded,
//                                               ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                         //   .closed
//                                         //   .then((value) {
//                                         // setState(() {
//                                         //   isButtomSheetShown = false;
//                                         // })
//                                         ;
//                                     controller.closed.then((value) {
//                                       setState(() {
//                                         isButtomSheetShown =
//                                             !isButtomSheetShown;
//                                       });
//                                     });
//                                   }

//                                   //   icon:
//                                   //   Icons.edit;
//                                   //   print(value);
//                                   // });
//                                   else {
//                                     // controller.close();
//                                     // isButtomSheetShown = false;
//                                     Navigator.of(context).pop();
//                                     setState(() {
//                                       isButtomSheetShown = !isButtomSheetShown;
//                                     });
//                                   }
//                                   setState(() {
//                                     build_row = true;
//                                   });

//                                   //////////
//                                 },
//                               ),

//                               // Container(
//                               //   alignment: Alignment.centerRight,
//                               //   width:
//                               //       MediaQuery.of(context).size.width / 2 * .8,
//                               //   padding: EdgeInsets.symmetric(horizontal: 20),
//                               //   height: 40,
//                               //   // decoration: BoxDecoration(
//                               //   //   // color: Colors.white,
//                               //   //   borderRadius: BorderRadius.circular(20),
//                               //   //   border: Border.all(color: Colors.grey),
//                               //   // ),
//                               //   child: DropdownButtonHideUnderline(
//                               //     child: DropdownButton(
//                               //       style: TextStyle(
//                               //           fontFamily: 'GE-medium',
//                               //           color: Colors.black),
//                               //       value: _register_data['name'],
//                               //       hint: Text('الاسم'),
//                               //       isExpanded: true,
//                               //       iconSize: 30,
//                               //       onChanged: (newval) {
//                               //         setState(() {
//                               //           _register_data['name'] =
//                               //               newval.toString();
//                               //         });
//                               //       },
//                               //       icon: Icon(Icons.keyboard_arrow_down),
//                               //       items: [
//                               //         'سامح الصقار',
//                               //         'محمد أحمد',
//                               //         'أكرم محمود'
//                               //       ]
//                               //           .map((item) => DropdownMenuItem(
//                               //                 child: Text(item),
//                               //                 value: item,
//                               //               ))
//                               //           .toList(),
//                               //     ),
//                               //   ),
//                               // ),

//                               Container(
//                                 alignment: Alignment.centerRight,
//                                 width:
//                                     MediaQuery.of(context).size.width / 2 * .8,
//                                 padding: EdgeInsets.symmetric(horizontal: 10),

//                                 // decoration: BoxDecoration(
//                                 //   // color: Colors.white,
//                                 //   borderRadius: BorderRadius.circular(20),
//                                 //   border: Border.all(color: Colors.grey),
//                                 // ),
//                                 child: SearchableDropdown<KeyValueModel>(
//                                   isCaseSensitiveSearch: true,
//                                   items: listan
//                                       .map((data) =>
//                                           DropdownMenuItem<KeyValueModel>(
//                                             child: Text(data.key),
//                                             value: data,
//                                           ))
//                                       .toList(),
//                                   onChanged: (KeyValueModel value) {
//                                     setState(() => _selectedValue = value);
//                                   },
//                                   hint: Text('الاسم'),
//                                 ),
//                               ),
//                               Text(
//                                 'A12345',
//                               ),
//                               // Container(
//                               //   // alignment: Alignment.centerRight,
//                               //   width:
//                               //       MediaQuery.of(context).size.width / 2 * .4,
//                               //   padding: EdgeInsets.symmetric(horizontal: 10),

//                               //   // decoration: BoxDecoration(
//                               //   //   // color: Colors.white,
//                               //   //   borderRadius: BorderRadius.circular(20),
//                               //   //   border: Border.all(color: Colors.grey),
//                               //   // ),
//                               //   child: SearchableDropdown<KeyValueCode>(
//                               //     isCaseSensitiveSearch: true,
//                               //     items: listan
//                               //         .map((data__code) =>
//                               //             DropdownMenuItem<KeyValueCode>(
//                               //               child: Text(data__code.key),
//                               //               value: data__code,
//                               //             ))
//                               //         .toList(),
//                               //     onChanged: (KeyValueCode value) {
//                               //       setState(() => _selectedCode = value  );
//                               //     },
//                               //     hint: Text('الكود'),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                         alignment: Alignment.center,
//                       ),
//                       decoration: BoxDecoration(
//                         color: kbackgroundColor1,
//                         border: Border.all(),
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: size.width * .8,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                       ),
//                       child: Row(
//                         children: [
//                           buildCell(size.width * .2, 'الحصه',
//                               bkground: kbuttonColor3),
//                           buildCell(size.width * .2, 'التاريخ',
//                               bkground: kbuttonColor3),
//                           buildCell(size.width * .2, 'الحضور',
//                               bkground: kbuttonColor3),
//                           buildCell(size.width * .2, 'الدرجه',
//                               bkground: kbuttonColor3),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: size.width * .8,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                       ),
//                       child: Row(
//                         children: [
//                           buildCell(size.width * .2, '1',
//                               bkground: Colors.white),
//                           buildCell(size.width * .2, '14/2',
//                               bkground: Colors.white),
//                           buildicon(size.width * .2, 'ok',
//                               bkground: Colors.white),
//                           buildCell(size.width * .2, '80',
//                               bkground: Colors.white),
//                         ],
//                       ),
//                     ),
//                     build_row ? buildRow() : SizedBox(),

//                     // while(table_len > 0) ? buildNewTable() : SizedBox(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void populateMultiselect() {
//     for (int v in valuestopopulate.keys) {
//       multiItem.add(CheckBox(v, valuestopopulate[v]!));
//     }
//   }

//   void _showMultiSelect(BuildContext context) async {
//     multiItem = [];
//     populateMultiselect();
//     final items = multiItem;

//     final selectedValues = await showDialog<Set<int>>(
//       context: context,
//       builder: (BuildContext context) {
//         return MultiSelectDialog(
//           items: items,
//           initialSelectedValues: [1, 2].toSet(),
//         );
//       },
//     );

//     // print(selectedValues);

//     getvaluefromkey(selectedValues!);
//   }

//   void getvaluefromkey(Set selection) {
//     if (selection != null) {
//       for (int x in selection.toList()) {
//         // print(valuestopopulate[x]);
//         value[index] = valuestopopulate[x]!;
//         // print(element);
//         // value[index] = element;
//         print(value[index]);
//         new_val = value.values.toList();
//         print('j');
//         print(
//           new_val[index],
//         );
//         print('j');
//         print(value.length);
//         setState(() {
//           index++;
//         });
//       }
//     }
//   }

//   Container buildCell(double width, String text,
//       {Color bkground = Colors.white}) {
//     return Container(
//       height: 30,
//       width: width,
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(fontFamily: 'GE-light'),
//         ),
//       ),
//       decoration: BoxDecoration(
//         border: Border.all(),
//         color: bkground,
//       ),
//     );
//   }

//   Widget buildNewTable() {
//     List<S2Choice<String>> groups = [
//       S2Choice<String>(value: 'مجموعة الساعة 1', title: 'مجموعة الساعة 1'),
//       S2Choice<String>(value: 'مجموعة الساعة 2', title: 'مجموعة الساعة 2'),
//       S2Choice<String>(value: 'مجموعة الساعة 3', title: 'مجموعة الساعة 3'),
//     ];
//     List<String> _groups = [];

//     return Center(
//       child: SmartSelect<String>.multiple(
//         title: ' ',
//         value: [],
//         onChange: (selected) => setState(() => _groups = selected.value),
//         choiceItems: groups,
//         modalType: S2ModalType.bottomSheet,
//         tileBuilder: (context, state) {
//           return S2Tile.fromState(
//             state,
//             isTwoLine: true,
//           );
//         },
//       ),
//     );
//   }

//   // Widget buildNewTable() {

//   //     return Container(
//   //       child: Container(
//   //         margin: EdgeInsets.symmetric(vertical: 20),
//   //         // width: size.width * .8,
//   //         decoration: BoxDecoration(
//   //           // color: Colors.red,
//   //           borderRadius: BorderRadius.only(
//   //             topLeft: Radius.circular(20),
//   //             topRight: Radius.circular(20),
//   //           ),
//   //         ),
//   //         child: Column(
//   //           children: [
//   //             Container(
//   //               // width: size.width * .8,
//   //               height: 30,
//   //               child: Align(
//   //                 child: Padding(
//   //                   padding: const EdgeInsets.symmetric(horizontal: 20),
//   //                   child: Row(
//   //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                     children: [
//   //                       Icon(
//   //                         Icons.add,
//   //                         color: Colors.black,
//   //                       ),
//   //                       Text(
//   //                         'سامح الصقار',
//   //                         style: TextStyle(
//   //                             fontFamily: 'GE-medium', color: Colors.black),
//   //                       ),
//   //                       Text(
//   //                         'A12345',
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 alignment: Alignment.center,
//   //               ),
//   //               decoration: BoxDecoration(
//   //                 color: kbackgroundColor1,
//   //                 border: Border.all(),
//   //                 borderRadius: BorderRadius.only(
//   //                   topLeft: Radius.circular(20),
//   //                   topRight: Radius.circular(20),
//   //                 ),
//   //               ),
//   //             ),
//   //             Container(
//   //               width: MediaQuery.of(context).size.width * .8,
//   //               height: 30,
//   //               decoration: BoxDecoration(
//   //                 color: Colors.green,
//   //               ),
//   //               child: Row(
//   //                 children: [
//   //                   buildCell(MediaQuery.of(context).size.width * .2, 'الحصه',
//   //                       bkground: kbuttonColor3),
//   //                   buildCell(MediaQuery.of(context).size.width * .2, 'التاريخ',
//   //                       bkground: kbuttonColor3),
//   //                   buildCell(MediaQuery.of(context).size.width * .2, 'الحضور',
//   //                       bkground: kbuttonColor3),
//   //                   buildCell(MediaQuery.of(context).size.width * .2, 'الدرجه',
//   //                       bkground: kbuttonColor3),
//   //                 ],
//   //               ),
//   //             ),
//   //             Container(
//   //               width: MediaQuery.of(context).size.width * .8,
//   //               height: 30,
//   //               decoration: BoxDecoration(
//   //                 color: Colors.green,
//   //               ),
//   //               child: Row(
//   //                 children: [
//   //                   buildCell(MediaQuery.of(context).size.width * .2, '1',
//   //                       bkground: Colors.white),
//   //                   buildCell(MediaQuery.of(context).size.width * .2, '14/2',
//   //                       bkground: Colors.white),
//   //                   buildicon(MediaQuery.of(context).size.width * .2, 'ok',
//   //                       bkground: Colors.white),
//   //                   buildCell(MediaQuery.of(context).size.width * .2, '80',
//   //                       bkground: Colors.white),
//   //                 ],
//   //               ),
//   //             ),
//   //           ],
//   //         ),

//   //       ),

//   //     );

//   // }

//   Widget buildRow() {
//     bool press_attend = pressattendence;
//     return Container(
//       width: MediaQuery.of(context).size.width * .8,
//       height: 30,
//       decoration: BoxDecoration(
//         color: Colors.green,
//       ),
//       child: Row(
//         children: [
//           buildCell(
//               MediaQuery.of(context).size.width * .2,
//               _register_data['class'] != null
//                   ? '${_register_data['class']}'
//                   : '',
//               bkground: Colors.white),
//           buildCell(MediaQuery.of(context).size.width * .2, '',
//               bkground: Colors.white),
//           buildicon(MediaQuery.of(context).size.width * .2, 'ok',
//               icon: icon, bkground: Colors.white , icon_color: icon_color),
//           buildCell(MediaQuery.of(context).size.width * .2,
//               '${degreeController.text}',
//               bkground: Colors.white),
//         ],
//       ),
//     );
//   }

//   Container buildicon(
//     double width,
//     String text, {
//     Color bkground = Colors.white,
//     icon,
//     icon_color,
//   }) {
//     return Container(
//       height: 30,
//       width: width,
//       child: Center(
//         child: Icon(
//           icon,
//           color: icon_color,
//         ),
//       ),
//       decoration: BoxDecoration(
//         border: Border.all(),
//         color: bkground,
//       ),
//     );
//   }
// }
