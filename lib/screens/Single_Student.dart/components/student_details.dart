import 'package:attendance/constants.dart';
import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/managers/Student_manager.dart';
import 'package:attendance/models/StudentSearchModel.dart';
import 'package:attendance/models/group.dart';
import 'package:attendance/models/groupmodelsimple.dart';
import 'package:attendance/screens/Single_Student.dart/components/name_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contacts_widget.dart';

class Student_details extends StatelessWidget {
  final String? stu_id;
  final user? myuser;
  StudentModelSearch? studentProfile;
  Student_details({
    Key? key,
    required this.size,
    this.stu_id,
    this.myuser,
    this.studentProfile,
  }) : super(key: key);

  final Size size;

  void _modalBottomSheetMenu(
    BuildContext context,
    List<GroupModelSimple> groups,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 250.0,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kbackgroundColor1,
                      ),
                      child: Center(
                        child: Text(
                          'مجموعات الطالب',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'GE-bold',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: (groups == null || groups.isEmpty)
                            ? Center(
                                child: Container(
                                  child: Text(
                                    'لا يوجد مجموعات',
                                    style: TextStyle(fontFamily: 'GE-light'),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: groups.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Provider.of<AppStateManager>(context,
                                            listen: false)
                                        .goToSingleStudentAttend(
                                            true, groups[index].id.toString());
                                  },
                                  child: ListTile(
                                    trailing: Container(
                                      width: size.width / 2,
                                      child: Text(
                                        '${groups[index].name}',
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'GE-light',
                                        ),
                                      ),
                                    ),
                                    subtitle: Container(
                                      width: size.width / 3,
                                      child: Text(
                                        '${groups[index].teacher!.name}',
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'GE-light',
                                        ),
                                      ),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor: kbackgroundColor3,
                                      radius: 10,
                                    ),
                                    title: Container(
                                      width: size.width / 3,
                                      child: Text(
                                        '${groups[index].subject!.name}',
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'GE-bold',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(
        Provider.of<StudentManager>(context, listen: true).singleStudent!.name);
    return Expanded(
      child: Container(
          child: Consumer<StudentManager>(
        builder: (builder, studentmanager, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (myuser != user.student)
                Name(
                    title: 'الاسم :',
                    size: size,
                    name: studentmanager.singleStudent!.name),
              if (myuser == user.student)
                Name(title: 'الاسم :', size: size, name: studentProfile!.name),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          'رقم التليفون',
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'GE-bold',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        // color: Colors.red,
                        width: size.width / 3,
                        child: Text(
                          myuser == user.center
                              ? studentmanager.singleStudent!.phone!
                              : studentProfile!.phone!,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Contacts_widget(size: size),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Container(
                      // color: Colors.red,
                      width: size.width * .3,
                      child: Text(
                        //رقم تليفون ولى الامر
                        'رقم تليفون ولى الامر',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,

                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'GE-bold',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: size.width / 3,
                      child: Text(
                        myuser == user.center
                            ? studentmanager.singleStudent!.parentPhone!
                            : studentProfile!.parentPhone!,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
              Contacts_widget(size: size),
              GestureDetector(
                onTap: () => _modalBottomSheetMenu(
                  context,
                  myuser == user.center
                      ? studentmanager.singleStudent!.groups!
                      : studentProfile!.groups!,
                ),
                child: Name(size: size, name: '  المجموعات', arrow: true),
              ),
              Name(
                  title: 'المحافظه :',
                  size: size,
                  name: myuser == user.center
                      ? studentmanager.singleStudent!.city!.name!
                      : studentProfile!.city!.name!),
              Name(
                title: 'المدرسه :',
                size: size,
                name: myuser == user.center
                    ? studentmanager.singleStudent!.school.toString()
                    : studentProfile!.school!.toString(),
              ),
              Name(
                  title: 'الشعبه :',
                  size: size,
                  name: myuser == user.center
                      ? studentmanager.singleStudent!.studyType.toString()
                      : studentProfile!.studyType!.toString()),
              Name(size: size, title: 'السداد:  '),
              Divider(
                thickness: 2,
              ),
              if (myuser == user.center)
                Name(
                    title: 'الملاحظات :',
                    size: size,
                    name: studentmanager.singleStudent!.note == null
                        ? 'لا يوجد ملاحظات'
                        : studentmanager.singleStudent!.note.toString()),
              if (myuser == user.student)
                Name(
                    title: 'الملاحظات :',
                    size: size,
                    name: studentProfile!.note == null
                        ? 'لا يوجد ملاحظات'
                        : studentProfile!.note.toString()),
            ],
          ),
        ),
      )),
    );
  }
}
