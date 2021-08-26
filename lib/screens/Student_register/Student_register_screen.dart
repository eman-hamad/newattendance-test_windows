import 'package:attendance/models/StudentSearchModel.dart';
import 'package:attendance/models/student.dart';
import 'package:attendance/navigation/screens.dart';
import 'package:flutter/material.dart';
import 'components/Register_form.dart';

class Student_Register_Screen extends StatelessWidget {
  final StudentModelSearch? myStudent;
  final bool? myedit;
  static MaterialPage page(
      {required StudentModelSearch editStudent, required edit}) {
    return MaterialPage(
      name: Attendance_Screens.student_registerpath,
      key: ValueKey(Attendance_Screens.student_registerpath),
      child: Student_Register_Screen(myStudent: editStudent, myedit: edit),
    );
  }

  const Student_Register_Screen({Key? key, this.myStudent, this.myedit})
      : super(key: key);

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              myedit! ? 'تعديل طالب' : 'تسجيل طالب',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'AraHamah1964B-Bold'),
            ),
          ),
          actions: [
            SizedBox(width: 10),
            CircleAvatar(
                minRadius: 25,
                backgroundImage: AssetImage('assets/images/pic.png')),
            SizedBox(
              width: 30,
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  // Provider.of<AppStateManager>(context, listen: false)
                  //     .go_to_Home();
                  Navigator.pop(context);
                },
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
          elevation: 0,
          // leading: Icon(
          //   Icons.menu,
          //   color: Colors.black,
          // ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
            child:
                Register_Form(size: size, edit: myedit, student: myStudent!)),
      ),
    );
  }
}
