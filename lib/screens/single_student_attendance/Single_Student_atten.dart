import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/managers/Student_manager.dart';
import 'package:attendance/models/attendgroupstudent.dart';
import 'package:attendance/navigation/screens.dart';
import 'package:attendance/screens/Single_Student.dart/components/student_pic_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'components/table_head_2.dart';

class Single_Student_attend extends StatelessWidget {
  final String? stId;
  final String? grId;

  static MaterialPage page({String? studentid, String? groupid}) {
    return MaterialPage(
      name: Attendance_Screens.single_student_attend,
      key: ValueKey(Attendance_Screens.single_student_attend),
      child: Single_Student_attend(
        grId: groupid!,
        stId: studentid!,
      ),
    );
  }

  const Single_Student_attend({Key? key, this.stId, this.grId})
      : super(key: key);

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kbackgroundColor2,
        appBar: AppBar(
          // leading: Icon(
          //   Icons.menu,
          //   color: Colors.black,
          // ),
          actions: [
            InkWell(
              onTap: () {
                Provider.of<AppStateManager>(context, listen: false)
                    .goToSingleStudentAttend(false, '');
              },
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
            child: Text(
              'حضور ودرجات طالب',
              style: TextStyle(color: Colors.black, fontFamily: 'GE-Bold'),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        // backgroundColor: kbackgroundColor2,
        body: (FutureBuilder<AttendGroupStudentModel>(
          future: Provider.of<StudentManager>(context, listen: false)
              .getAttendanceStudent(grId!, stId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Column(
                children: [
                  Student_pic_name(),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'اسم الماده',
                        //   style: TextStyle(fontFamily: 'GE-medium'),
                        // ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' المدرس:  ${snapshot.data!.teacher!.name!}',
                          style: TextStyle(fontFamily: 'GE-medium'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' المجموعه:  ${snapshot.data!.name!}',
                          style: TextStyle(fontFamily: 'GE-medium'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TABLE_HEAD_2(
                          size: size,
                          data: ['الحصه', 'التاريخ', 'الحضور', 'الدرجه'],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.appointments!.length,
                            itemBuilder: (context, index) => TABLE_HEAD_2(
                              myindex: index,
                              attend: snapshot.data,
                              head: false,
                              size: size,
                              data: [
                                snapshot.data!.appointments![index].time,
                                snapshot.data!.appointments![index].date,
                                true,
                                snapshot.data!.appointments![index].degree
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        )),
      ),
    );
  }
}
