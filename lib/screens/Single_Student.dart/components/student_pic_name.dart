import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/managers/Student_manager.dart';
import 'package:attendance/models/StudentSearchModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Student_pic_name extends StatelessWidget {
  final String? stu_id;
  final StudentModelSearch? studetprofile;
  final user? myuser;
  Student_pic_name({
    Key? key,
    this.stu_id,
    this.studetprofile,
    this.myuser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(myuser);
    print(myuser);
    print(myuser);
    return Column(
      children: [
        Consumer<StudentManager>(
            builder: (builder, studetmanager, child) => Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 75,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (myuser == user.center)
                        InkWell(
                          onTap: () {
                            // print(stu_id);
                            Provider.of<AppStateManager>(context, listen: false)
                                .studentTapped(stu_id!, true,
                                    studetmanager.singleStudent!);
                          },
                          child: Icon(Icons.edit),
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      if (myuser == user.center)
                        Consumer<StudentManager>(
                          builder: (builder, studentmanager, child) => Text(
                            studentmanager.singleStudent!.name!,
                            style: TextStyle(
                                fontSize: 35,
                                color: Colors.blue,
                                fontFamily: 'AraHamah1964B-Bold'),
                          ),
                        ),
                      if (myuser == user.student)
                        Text(
                          studetprofile!.name!,
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.blue,
                              fontFamily: 'AraHamah1964B-Bold'),
                        ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                          minRadius: 30,
                          backgroundImage: AssetImage('assets/images/pic.png')),
                    ],
                  ),
                ))
      ],
    );
  }
}
