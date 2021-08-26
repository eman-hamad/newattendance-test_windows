import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/managers/Student_manager.dart';
import 'package:attendance/models/StudentSearchModel.dart';
import 'package:attendance/navigation/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

import 'components/student_details.dart';
import 'components/student_pic_name.dart';

// final GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey<ScaffoldState>();

class Single_Student_Screen extends StatefulWidget {
  final String? student_id;
  final StudentModelSearch? studentprofile;
  final user? myuser;
  static MaterialPage page(
      {String? studentid, StudentModelSearch? userstudent, user? user}) {
    return MaterialPage(
      name: Attendance_Screens.single_student,
      key: ValueKey(Attendance_Screens.single_student),
      child: Single_Student_Screen(
        student_id: studentid,
        studentprofile: userstudent,
        myuser: user,
      ),
    );
  }

  const Single_Student_Screen(
      {Key? key, this.student_id, this.studentprofile, this.myuser})
      : super(key: key);

  @override
  _Single_Student_ScreenState createState() => _Single_Student_ScreenState();
}

class _Single_Student_ScreenState extends State<Single_Student_Screen> {
  bool _isLoading = true;

  @override
  void initState() {
    // print('asdasdasd');
    super.initState();
    if (widget.myuser == user.center)
      Future.delayed(Duration.zero, () async {
        await Provider.of<StudentManager>(context, listen: false)
            .getMoreDatafilteredId(widget.student_id.toString())
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      });
    if (widget.myuser == user.student) _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // key: _scaffoldKey2,
        resizeToAvoidBottomInset: false,
        backgroundColor: kbackgroundColor2,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.myuser == user.center) Container(),
                        if (widget.myuser == user.student)
                          Builder(
                            builder: (context) => InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                                // Provider.of<Auth_manager>(context, listen: false)
                                //     .logout();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.menu_sharp),
                              ),
                            ),
                          ),
                        Text(
                          widget.myuser == user.center
                              ? 'صفحه طالب '
                              : 'الصفحه الشخصيه ',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'AraHamah1964B-Bold'),
                        ),
                        if (widget.myuser == user.center)
                          Container(
                            padding: EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: RotatedBox(
                                quarterTurns: 2,
                                child: Icon(
                                  Icons.arrow_back,
                                ),
                              ),
                            ),
                          ),
                        if (widget.myuser == user.student) Container()
                      ],
                    ),
                  ),
                  Student_pic_name(
                    stu_id: widget.student_id,
                    studetprofile: widget.studentprofile,
                    myuser: widget.myuser,
                  ),
                  SizedBox(height: 5),
                  // if (widget.myuser == user.center)
                  Student_details(
                    stu_id: widget.student_id,
                    size: size,
                    studentProfile: widget.studentprofile,
                    myuser: widget.myuser,
                  )
                ],
              ),
        drawer: widget.myuser == user.student
            ? Drawer(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/images/logo.jpg',
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      height: 200,
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.7,
                                  ),
                                ),
                                height: 40,
                                child: Material(
                                  // elevation: 5.0,
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Center(
                                    child: Text(
                                      "تسجيل الخروج",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Provider.of<Auth_manager>(context, listen: false)
                                  .logout();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
