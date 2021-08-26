// // import 'package:searchable_dropdown/searchable_dropdown.dart';
// // import 'package:flutter/material.dart';

// // class MyHomePage extends StatefulWidget {

// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {

// //   String _selectedValue = '';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Padding(
// //         padding: EdgeInsets.only(top: 50),
// //         child: SearchableDropdown.single(
// //           items: ['solll','eooll','ahhhh'].map((e){
// //             return DropdownMenuItem<dynamic>(
// //               child: Text(e),
// //             );
// //           }).toList(),
// //           value: _selectedValue,
// //           hint: _selectedValue != null ? "Select one" : _selectedValue,
// //           searchHint: "Select one",
// //           onChanged: (value) {
// //             setState(() {
// //               _selectedValue = value;
// //             });
// //           },
// //           isExpanded: true,
// //         )
// //       )
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';

// get_list() {
//   List<KeyValueModel> datas = [
//     KeyValueModel(key: "أ", value: "Value 1"),
//     KeyValueModel(key: "بمم", value: "Value 2"),
//     KeyValueModel(key: "اخنن", value: "Value 3"),
//     KeyValueModel(key: "يحح", value: "Value 4"),
//     KeyValueModel(key: "سا", value: "Value 5"),
//   ];
//   return datas;
// }

// //Create a Model class to hold key-value pair data
// class KeyValueModel {
//   String key;
//   String? value;

//   KeyValueModel({required this.key, this.value});

//     @override
//     String toString() {
//     return key;
//   }
// }

// class Test extends StatefulWidget {
//   @override
//   TestState createState() {
//     return new TestState();
//   }
// }

// class TestState extends State<Test> {
//   List listan = get_list();

//   KeyValueModel _selectedValue = KeyValueModel(key: "0", value: "value");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Key value Pair - DropdownButton'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             SearchableDropdown<KeyValueModel>(
//               isCaseSensitiveSearch: true,
//               items: listan
//                   .map((data) => DropdownMenuItem<KeyValueModel>(
//                         child: Text(data.key),
//                         value: data,
//                       ))
//                   .toList(),
//               onChanged: (KeyValueModel value) {
//                 setState(() => _selectedValue = value);
//               },
//               hint: Text('Select Key'),
//             ),
//             SizedBox(
//               height: 25.0,
//             ),
//             Text(_selectedValue.value!),
//           ],
//         ),
//       ),
//     );
//   }
// }
