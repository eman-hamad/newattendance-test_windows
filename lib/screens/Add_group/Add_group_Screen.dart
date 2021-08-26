import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/models/teacher.dart';
import 'package:attendance/navigation/screens.dart';
import 'package:attendance/screens/Add_group/components/group_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Add_group_screen extends StatelessWidget {
  final user? myuser;
  final TeacherModel? teacher;

  static MaterialPage page({TeacherModel? userteahcer, user? user}) {
    return MaterialPage(
      name: Attendance_Screens.group_registerpath,
      key: ValueKey(Attendance_Screens.group_registerpath),
      child: Add_group_screen(
        myuser: user,
        teacher: userteahcer,
      ),
    );
  }

  const Add_group_screen({Key? key, this.myuser, this.teacher})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'تسجيل مجموعه',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'AraHamah1964B-Bold'),
            ),
          ),
          actions: [
            SizedBox(width: 10),
            CircleAvatar(
              minRadius: 25,
              backgroundImage: AssetImage('assets/images/Group.png'),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Provider.of<AppStateManager>(context, listen: false)
                      .registerGroup(false);
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
          // leading:
          //  Icon(
          //   Icons.menu,
          //   color: Colors.black,
          // ),

          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: group_form(size: size, tuser: myuser, teacher: teacher),
        ),
      ),
    );
  }
}
