// import 'package:flutter/material.dart';

// class Degrees_top extends StatefulWidget {
//   const Degrees_top({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _Degrees_topState createState() => _Degrees_topState();
// }

// class _Degrees_topState extends State<Degrees_top> {
//   static bool pressed = false;
//   @override
//   Widget build(BuildContext context) {
//     // var size = widget.size;
//     return Container(
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Text(
//               'سنتر الياسمين :1:30',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Spacer(),
//             Column(
//               children: [
//                 IconButton(
//                     icon: Icon(
//                       Icons.check,
//                       size: 60,
//                       color: Colors.green,
//                     ),
//                     onPressed: () {}),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       pressed = true;
//                     });
//                   },
//                   child: Container(
//                     alignment: Alignment.centerRight,
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     height: 30,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Colors.grey),
//                     ),
//                     child: Container(
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "أضافة مجموعة",
//                             style: TextStyle(fontFamily: 'GE-medium'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Container(
//                   alignment: Alignment.centerRight,
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   height: 30,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.grey),
//                   ),
//                   child: Container(
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "كل المجموعات",
//                           style: TextStyle(fontFamily: 'GE-medium'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // pressed ? buildNewTable(): SizedBox(),
//           ],
//         ),
//       ),
//     );
//     // Column(
//     //   children: [
//     //     Container(
//     //       alignment: Alignment.center,
//     //       width: double.infinity,
//     //       height: 75,
//     //       color: Colors.white,
//     //       child: Row(
//     //         mainAxisAlignment: MainAxisAlignment.center,
//     //         children: [
//     //           Text(
//     //             'الدرجات',
//     //             style: TextStyle(
//     //                 fontSize: 35,
//     //                 color: Colors.blue,
//     //                 fontFamily: 'AraHamah1964B-Bold'),
//     //           ),
//     //           SizedBox(
//     //             width: 20,
//     //           ),
//     //           CircleAvatar(
//     //               minRadius: 30,
//     //               backgroundImage: AssetImage('assets/images/Group.png')),
//     //         ],
//     //       ),
//     //     )
//     //   ],
//     // );
//   }

//   Widget buildNewTable() {
//     // pressed = true;
//     print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//     return Container(child: Text("hhhhhhhhhhhh"));
//   }
//   //  Container(
//   //                     margin: EdgeInsets.symmetric(vertical: 20),
//   //                     width: size.width * .8,
//   //                     decoration: BoxDecoration(
//   //                       color: Colors.red,
//   //                       borderRadius: BorderRadius.only(
//   //                         topLeft: Radius.circular(20),
//   //                         topRight: Radius.circular(20),
//   //                       ),
//   //                     ),
//   //                     child: Column(
//   //                       children: [
//   //                         Container(
//   //                           width: size.width * .8,
//   //                           height: 30,
//   //                           child: Align(
//   //                             child: Padding(
//   //                               padding:
//   //                                   const EdgeInsets.symmetric(horizontal: 20),
//   //                               child: Row(
//   //                                 mainAxisAlignment:
//   //                                     MainAxisAlignment.spaceBetween,
//   //                                 children: [
//   //                                   Icon(
//   //                                     Icons.add,
//   //                                     color: Colors.black,
//   //                                   ),
//   //                                   Text(
//   //                                     'سامح الصقار',
//   //                                     style: TextStyle(
//   //                                         fontFamily: 'GE-medium',
//   //                                         color: Colors.black),
//   //                                   ),
//   //                                   Text(
//   //                                     'A12345',
//   //                                   ),
//   //                                 ],
//   //                               ),
//   //                             ),
//   //                             alignment: Alignment.center,
//   //                           ),
//   //                           decoration: BoxDecoration(
//   //                             color: kbackgroundColor1,
//   //                             border: Border.all(),
//   //                             borderRadius: BorderRadius.only(
//   //                               topLeft: Radius.circular(20),
//   //                               topRight: Radius.circular(20),
//   //                             ),
//   //                           ),
//   //                         ),
//   //                         Container(
//   //                           width: size.width * .8,
//   //                           height: 30,
//   //                           decoration: BoxDecoration(
//   //                             color: Colors.green,
//   //                           ),
//   //                           child: Row(
//   //                             children: [
//   //                               buildCell(size.width * .2, 'الحصه',
//   //                                   bkground: kbuttonColor3),
//   //                               buildCell(size.width * .2, 'التاريخ',
//   //                                   bkground: kbuttonColor3),
//   //                               buildCell(size.width * .2, 'الحضور',
//   //                                   bkground: kbuttonColor3),
//   //                               buildCell(size.width * .2, 'الدرجه',
//   //                                   bkground: kbuttonColor3),
//   //                             ],
//   //                           ),
//   //                         ),
//   //                         Container(
//   //                           width: size.width * .8,
//   //                           height: 30,
//   //                           decoration: BoxDecoration(
//   //                             color: Colors.green,
//   //                           ),
//   //                           child: Row(
//   //                             children: [
//   //                               buildCell(size.width * .2, '1',
//   //                                   bkground: Colors.white),
//   //                               buildCell(size.width * .2, '14/2',
//   //                                   bkground: Colors.white),
//   //                               buildicon(size.width * .2, 'ok',
//   //                                   bkground: Colors.white),
//   //                               buildCell(size.width * .2, '80',
//   //                                   bkground: Colors.white),
//   //                             ],
//   //                           ),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   );
// }
