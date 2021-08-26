// import 'package:attendance/managers/Appointment_manager.dart';
// import 'package:attendance/managers/group_manager.dart';
// import 'package:attendance/models/StudentModelSimple.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../constants.dart';

// class ListItem extends StatefulWidget {
//    AppointmentManager appmgr;
//   @required final int Index ;
//   ListItem(this.Index , this.appmgr);
//   @override
//   _ListItemState createState() => _ListItemState();
// }

// class _ListItemState extends State<ListItem> {
  
//   bool show_text = false;
//   List<bool> checkBoxValues = [];
//   String? Group_Id;
//   int? Student__id;
//   var added_degrees = [];
//   int i = 0;
//   bool isLoading = false;
//   bool checked = false;
//   bool select_all = false;
//   var colors = [
//     kbuttonColor3.withOpacity(.8),
//     kbuttonColor3.withOpacity(.6),
//   ];
//   var yearController = TextEditingController();
//   var degreeController = TextEditingController();

//   String text_value = '';

//   bool _isloading = true;
//   List<bool> _isChecked = [];
//   int search_list_length = 0;
//   var text_colors = [Colors.black, Colors.black];
//   String text = '';

//   Map<String, dynamic> _add_data = {
//     'year': null,
//   };
//   List<String> search_list = [];
//   String result = '';
//   List<String> userChecked = [];
//   List<StudentModelSimple> search_list_all = [];
//   TextEditingController searchController = new TextEditingController();
//   int _selectedIndex = 0;

//   _onSelected(int index) {
//     setState(() => _selectedIndex = index);
//   }

//   Icon _searchIcon = new Icon(Icons.search);

//   void _Selected(bool selected, String dataName) {
//     if (selected == true) {
//       setState(() {
//         userChecked.add(dataName);
//       });
//     } else {
//       setState(() {
//         userChecked.remove(dataName);
//       });
//     }
//   }

//   bool sent = false;
//   String Lesson_Id = '';
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   FocusNode fnode = FocusNode();
//   var _isLoading = false;
//   void _submit(Student__id) async {
//     setState(() {
//       _isLoading = true;
//     });
//     // try {
//     setState(() {
//       Group_Id;
//     });
//     await Provider.of<GroupManager>(context, listen: false)
//         .add_degree(result, '$Student__id', Lesson_Id)
//         .then((_) {
//           result = '';
//           setState(() {
//             sent = true;
//           });
//         })
//         .then((value) => setState(() {
//               _isLoading = false;
//             }))
//         .then(
//           (_) => ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               backgroundColor: Colors.green[300],
//               content: Text(
//                 'تم اضافه الدرجة بنجاح',
//                 style: TextStyle(fontFamily: 'GE-medium'),
//               ),
//               duration: Duration(seconds: 3),
//             ),
//           ),
//         );
//     //}
//     // on HttpException catch (error) {
//     //   _showErrorDialog('حاول مره اخري ', 'حدث خطأ');
//     // } catch (error) {
//     //   _showErrorDialog('حاول مره اخري ', 'حدث خطأ');
//     // }
//     // setState(() {
//     //   _isLoading = false;
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: CheckboxListTile(
        
//         value: userChecked.contains(search_list[widget.Index]),
//         onChanged: (val) {
//           _Selected(val!, search_list[widget.Index]);
//           print('vallllllllllllllllll');
//           print(val);
//           // checked = val;
//           setState(() {
//             checked = val;
//             if (checked == true) {
//               show_text = true;
//               _onSelected(widget.Index);
//             }
//           });
//         },
//         // val
//         //
//         //
//         //

//         // value: _isChecked[Index],
//         // onChanged: (val) {
//         //   setState(
//         //     () {
//         //       print('valllllllllll');
//         //       print(Index);
//         //       print(
//         //         _isChecked[Index],
//         //       );
//         //       print('val');
//         //       print(val);
//         //       _isChecked[Index] = val!;
//         //       print('_isChecked[Index],');
//         //       print(
//         //         _isChecked[Index],
//         //       );
//         //       print(_isChecked);

//         //       // itemChange(val, Index);
//         //     },

//         //);
//         // },
//         title: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 5),
//               color: colors[widget.Index % colors.length],
//               child: ListTile(
//                 trailing: Text(
//                   // 'شسيشسي',
//                   widget.appmgr.student_attend[widget.Index].phone ?? '',
//                   style: TextStyle(
//                       color: text_colors[widget.Index % colors.length],
//                       fontFamily: 'GE-light'),
//                 ),
//                 // subtitle: Text(
//                 //   // 'شسيشسي',
//                 //   appmgr.student_attend[Index].code!.name ?? '',
//                 //   style: TextStyle(
//                 //       color: text_colors[Index % colors.length],
//                 //       fontFamily: 'GE-light'),
//                 // ),
//                 onTap: () {
//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //         builder: (context) => Show_Group_Class()));
//                   // Provider.of<AppStateManager>(context,
//                   //         listen: false)
//                   //     .goToSinglegroup(
//                   //         true,
//                   //         appmgr.groups[Index].id
//                   //             .toString(),
//                   //         appmgr.groups[Index]);
//                 },
//                 title: Text(
//                   // 'شسيشسي',

//                   widget.appmgr.student_attend[widget.Index].name!,
//                   style: TextStyle(
//                       color: text_colors[widget.Index % colors.length],
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'GE-medium'),
//                 ),

//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Container(
//                 //     decoration: BoxDecoration(
//                 //       borderRadius:
//                 //           BorderRadius.all(Radius.circular(5)),
//                 //       border: Border.all(
//                 //         color: Colors.grey,
//                 //         width: 0.7,
//                 //       ),
//                 //     ),
//                 //     height: 50,
//                 //     child: Material(
//                 //       elevation: 5.0,
//                 //       borderRadius: BorderRadius.circular(5.0),
//                 //       color: colors[Index % colors.length],
//                 //       child: Center(
//                 //         child: Text(
//                 //           groupManager.groups[Index].name!,
//                 //           style: TextStyle(
//                 //               color: text_colors[
//                 //                   Index % colors.length],
//                 //               fontWeight: FontWeight.bold),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ),
//             ),
//             // Row(
//             //   children: [
//             // sent == true
//             //     ? Container(
//             //         width: 80,
//             //         height: 35,
//             //         color: colors[Index %
//             //             colors.length],
//             //         child: Center(
//             //           child: Text(
//             //             // degreeController.text,

//             //             // added_degrees[i] ==
//             //             //         appmgr
//             //             //             .student_attend[
//             //             //                 Index]
//             //             //             .parentPhone!
//             //             //     ? added_degrees[i]
//             //             appmgr
//             //                 .appointments_degree![
//             //                     Index]
//             //                 .degree!,
//             //             // appmgr
//             //             //     .appointments_degree![Index].degree!,

//             //             style: TextStyle(
//             //                 color:
//             //                     Colors.black,
//             //                 fontWeight:
//             //                     FontWeight
//             //                         .bold,
//             //                 fontSize: 18),
//             //           ),
//             //         ),
//             //       )
//             //     : SizedBox(),
//             // Spacer(),
//             //     Align(
//             //       alignment: Alignment.topLeft,
//             //       child: MaterialButton(
//             //         color: Colors.black,
//             //         onPressed: () {
//             //           // setState(() {

//             //           // });
//             //           _onSelected(Index);
//             //           // Scaffold.of(context);
//             //           // Provider.of<AppStateManager>(
//             //           //    context,
//             //           //
//             //           //
//             //           //   listen: false);
//             //           // for (i;
//             //           //     i <= list_index.length;
//             //           //     i++) {
//             //           if (_selectedIndex ==
//             //               Index) {
//             //             setState(() {
//             //               show_text = !show_text;

//             //               _selectedIndex;
//             //               _submit();
//             //               sent;
//             //               print('degree');
//             //               print(appmgr
//             //                   .student_attend[
//             //                       Index]
//             //                   .name);
//             //               added_degrees.add(appmgr
//             //                   .student_attend[
//             //                       Index]
//             //                   .parentPhone);

//             //               added_degrees;
//             //               i;
//             //               Lesson_Id;

//             //               get_degree();
//             //               print('degreeeeeeeeee');
//             //               print(appmgr
//             //                   .appointments_degree![
//             //                       Index]
//             //                   .discount!);

//             //               print('degreeeeeeeeee');
//             //               // print( appmgr
//             //               //       .appointment[Index].id);

//             //               print('degreeeeeeeeee');
//             //               // print( appmgr
//             //               //       .appointment[Index].students![Index].degree!);
//             //             });
//             //           }
//             //           // _submit();

//             //           // }
//             //           get_degree();
//             //         },
//             //         child: Text(
//             //           //context:ctxt,
//             //           show_text &&
//             //                   _selectedIndex ==
//             //                       Index
//             //               ? 'حفظ'
//             //               : button_text,

//             //           style: TextStyle(
//             //             color: Colors.white,
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             _selectedIndex != null &&
//                     _selectedIndex == widget.Index &&
//                     checked == true
//                 //list_index[index]
//                 ? Row(children: [
//                     Text(
//                       'الدرجة ',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Visibility(
//                       visible: true,
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: Container(
//                           width: 90,
//                           color: colors[widget.Index % colors.length],
//                           child: TextField(
//                             // onFieldSubmitted: (val) {
//                             //   print('v_vallllll');
//                             //   print(val);
//                             // },
//                             style: TextStyle(
//                                 // color: Colors
//                                 //     .white,
//                                 fontWeight: FontWeight.bold),
//                             onSubmitted: (String str) {
//                               setState(() {
//                                 result = str;
//                                 print('ressssssssult');
//                                 print(result);

//                                 if (_selectedIndex == widget.Index) {
//                                   setState(() {
//                                     show_text = !show_text;

//                                     _selectedIndex;
//                                     _submit(
//                                         widget.appmgr.student_attend[widget.Index].id);
//                                     checked = false;
//                                     sent;
//                                     print('degree');
//                                     print(widget.appmgr
//                                         .student_attend[widget.Index].name);
//                                     added_degrees.add(widget.appmgr
//                                         .student_attend[widget.Index]
//                                         .parentPhone);

//                                     added_degrees;
//                                     i;
//                                     Lesson_Id;

//                                     // get_degree();
//                                     // print('degreeeeeeeeee');
//                                     // print(appmgr
//                                     //     .appointments_degree![
//                                     //         Index]
//                                     //     .discount!);

//                                     // print('degreeeeeeeeee');
//                                     // print( appmgr
//                                     //       .appointment[Index].id);

//                                     print('degreeeeeeeeee');
//                                     // print( appmgr
//                                     //       .appointment[Index].students![Index].degree!);
//                                   });
//                                 }

//                                 // _submit();
//                               });
//                               degreeController.clear();
//                             },
//                             // onSaved: (v) {

//                             //    print('v_vvvvvvvvv');
//                             //   print(v);
//                             // },
//                             controller: degreeController,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ])
//                 //Text(result)
//                 : SizedBox(),
//             // result.isEmpty==true
//             //  ?SnackBar(content: Text('اضغط ok لكي تضيف الدرجة')):
//             //  SizedBox()

//             // Text('data'),
//             // defaultFormField(
//             //   controller:degreeController ,
//             //   type: TextInputType.number,
//             //   validate: (){},
//             //   //  text: '',
//             //   // isPassword: false,
//             //   prefix: Icons.format_list_numbered

//             // ),
//             // Edit_Text(size: size, name: ''),

//             // TextFormField(),
//             // SizedBox(
//             //   width: 15,
//             // ),

//             // Text("jjj")

//             // SizedBox(
//             //     height: 10,
//             //   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
