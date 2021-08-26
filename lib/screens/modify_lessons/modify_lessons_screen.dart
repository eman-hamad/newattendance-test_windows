import 'package:attendance/navigation/screens.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

import 'components/lessons_top_page.dart';

class Modify_Lessons_screen extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Attendance_Screens.lesson_modify,
      key: ValueKey(Attendance_Screens.lesson_modify),
      child: const Modify_Lessons_screen(),
    );
  }

  const Modify_Lessons_screen({Key? key}) : super(key: key);

  @override
  _Modify_Lessons_screenState createState() => _Modify_Lessons_screenState();
}

List<String> lessons = ['حصه1', 'حصه2'];
var _choosedLesson = null;

class _Modify_Lessons_screenState extends State<Modify_Lessons_screen> {
  final _formKey = GlobalKey<FormState>();
  late String _reason;
  DateTime selectedDate = DateTime.now();

  void showdialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        child: Text(
                          'الغاء حصه',
                          style: TextStyle(fontFamily: 'GE-Bold'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        child: TextFormField(
                          onSaved: (value) {
                            _reason = value.toString();
                          },
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            hintText: 'السبب',
                            hintStyle: TextStyle(
                              fontFamily: 'GE-medium',
                            ),
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            color: kbackgroundColor3,
                            child: Text(
                              "تاكيد",
                              style: TextStyle(
                                  fontFamily: 'GE-medium', color: Colors.black),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Navigator.of(context).pop();
                                // Provider.of<AppStateManager>(context,
                                //         listen: false)
                                //     .go_to_Home();
                                Navigator.pop(context);
                              }
                            },
                          ),
                          RaisedButton(
                            color: kbackgroundColor3,
                            child: Text(
                              "إلغاء",
                              style: TextStyle(
                                  fontFamily: 'GE-medium', color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    // Provider.of<AppStateManager>(context, listen: false).go_to_Home();
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: build_App_bar(
          'تعديل حصه',
          Icons.menu,
          Container(),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: kbackgroundColor2,
        body: (Column(
          children: [
            Lessons_top_page(title: 'سنتر الياسمين 1:30'),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  width: size.width * .9,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        style: TextStyle(
                            fontFamily: 'GE-medium', color: Colors.black),
                        value: _choosedLesson,
                        hint: Text('اختار حصه'),
                        isExpanded: true,
                        iconSize: 30,
                        onChanged: (newval) {
                          setState(() {
                            _choosedLesson = newval.toString();
                          });
                        },
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: lessons
                            .map((item) => DropdownMenuItem(
                                  child: Text(item),
                                  value: item,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: size.width * .9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: _choosedLesson == null ? () {} : showdialog,
                            child: choose_button(size: size, title: 'إلغاء')),
                        InkWell(
                            onTap: _choosedLesson == null
                                ? () {}
                                : () => _selectDate(context),
                            child: choose_button(size: size, title: 'تعديل')),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }

  AppBar build_App_bar(String title, IconData icon, Widget icon2) {
    return AppBar(
      centerTitle: true,
      actions: [icon2],
      backgroundColor: Colors.white,
      elevation: 0,
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'GE-Bold',
            color: Colors.black,
          ),
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}

class choose_button extends StatelessWidget {
  const choose_button({
    Key? key,
    required this.size,
    required this.title,
  }) : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .2,
      height: 40,
      decoration: BoxDecoration(
        color: kbackgroundColor3,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, .5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'AraHamah1964B-Bold',
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
