import 'package:attendance/models/StudentSearchModel.dart';
import 'package:attendance/models/appointment.dart';
import 'package:attendance/models/groupmodelsimple.dart';
import 'package:attendance/models/student.dart';
import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {
  // home screen state.. start
  // ignore: non_constant_identifier_names
  bool _home_options = false;
  bool _student_register = false;
  bool _teacher_register = false;
  bool _group_register = false;
  bool _communicate_students = false;
  bool _data_students = false;
  bool _lesson_modify = false;
  bool _subjects_modify = false;
  bool _years_add = false;

  bool _singleStudentfromHome = false;
  // home screen state.. end

  // students page .. start
  bool _single_student = false;
  // students page .. end

  // students page .. start
  bool _single_student_attend = false;

  bool _groupscheck = false;
  // students page .. end

  // home screen state.. start
  bool get homeOptions => _home_options;
  bool get studentRegister => _student_register;
  bool get teacherRegister => _teacher_register;
  bool get groupRegister => _group_register;
  bool get communicateStudents => _communicate_students;
  bool get dataStudents => _data_students;
  bool get lessonModify => _lesson_modify;
  bool get subjectsModify => _subjects_modify;
  bool get yearsAdd => _years_add;
  bool get singleStudentFromHome => _singleStudentfromHome;
  bool get groupscheck => _groupscheck;
  // home screen end

  // students page .. start
  bool get singleStudent => _single_student;
  // students page .. end

  // students page .. start
  bool get singleStudentAttend => _single_student_attend;
  // students page .. end

  String _group_id_selected = '';
  GroupModelSimple _groupselected = GroupModelSimple();
  String get groupIdSelected => _group_id_selected;
  GroupModelSimple get getGroupSelected => _groupselected;
  String _student_id_selected = '';
  String get studentIdSelected => _student_id_selected;

  String _editStudentid = '';
  String get geteditStudentID => _editStudentid;
  bool _editStudent = false;
  bool get geteditstudent => _editStudent;
  StudentModelSearch _student = StudentModelSearch();
  StudentModelSearch get getstudent => _student;

  bool _singlegroup = false;
  bool get singlegroup => _singlegroup;

  GroupModelSimple _mygroupshow = GroupModelSimple();
  GroupModelSimple get mygroupshow => _mygroupshow;

  String _singlegroupid = '';
  String get mysinglegroup => _singlegroupid;

  bool _singlelessonbool = false;
  bool get singlelessonbool => _singlelessonbool;

  String _singlelessonid = '';
  String get singlelessonid => _singlelessonid;

  AppointmentModel _singlelesson = AppointmentModel();
  AppointmentModel get getsinglelesson => _singlelesson;

  void setstudent(StudentModelSearch st) {
    _student = st;
  }

  void setgroupID(String value, GroupModelSimple group) {
    _group_id_selected = value;
    _groupselected = group;
    notifyListeners();
  }

  void setStudentID(String value) {
    _student_id_selected = value;
    notifyListeners();
  }

  void gotocheckgroups(bool value) {
    _groupscheck = value;
    notifyListeners();
  }

  void setHomeOptions(bool value) {
    _home_options = value;
    notifyListeners();
  }

  void registerStudent(bool value) {
    _student_register = value;
    notifyListeners();
  }

  void registerTeacher(bool value) {
    _teacher_register = value;
    notifyListeners();
  }

  void registerGroup(bool value) {
    _group_register = value;
    notifyListeners();
  }

  void studentsCommunicate(bool value) {
    _communicate_students = value;
    notifyListeners();
  }

  void studentsData(bool value) {
    _data_students = value;
    notifyListeners();
  }

  void modifyLesson() {
    _lesson_modify = true;
    notifyListeners();
  }

  void modifySubjects(bool value) {
    _subjects_modify = value;
    notifyListeners();
  }

  void addYears(bool value) {
    _years_add = value;
    notifyListeners();
  }

  void goToSingleStudent(bool value, StudentModelSearch st, String id) {
    _single_student = value;
    _student = st;
    _student_id_selected = id;
    notifyListeners();
  }

  void goToSinglegroup(bool value, String id, GroupModelSimple group) {
    _singlegroup = value;
    _singlegroupid = id;
    _mygroupshow = group;
    notifyListeners();
  }

  void goToSinglelessonattend(bool value, String id, AppointmentModel lesson) {
    _singlelessonbool = value;
    _singlelessonid = id;
    _singlelesson = lesson;
    notifyListeners();
  }

  void goToSingleStudentAttend(bool value, String groupid) {
    _singlegroupid = groupid;
    _single_student_attend = value;
    notifyListeners();
  }

  void goToSingleStudentfromHome(bool value, String id) {
    _singleStudentfromHome = value;
    _student_id_selected = id;

    notifyListeners();
  }

  // void go_to_Home() {
  //   _student_register = false;
  //   _teacher_register = false;
  //   _group_register = false;
  //   _communicate_students = false;
  //   _data_students = false;
  //   _lesson_modify = false;
  //   _subjects_modify = false;
  //   _years_add = false;
  //   _singleStudentfromHome = false;
  //   /////////////////////////
  //   _editStudent = false;
  //   notifyListeners();
  // }

  void studentTapped(String id, bool value, StudentModelSearch stu) {
    _editStudentid = id;
    _editStudent = value;
    _student = stu;
    notifyListeners();
  }
}
