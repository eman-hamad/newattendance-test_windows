import 'dart:convert';
import 'dart:io';
import 'package:attendance/helper/httpexception.dart';
import 'package:attendance/models/StudentModelSimple.dart';
import 'package:attendance/models/StudentSearchModel.dart';
import 'package:attendance/models/attendgroupstudent.dart';
import 'package:attendance/models/group.dart';
import 'package:attendance/models/groupmodelsimple.dart';
import 'package:dio/dio.dart';

import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/models/student.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentManager extends ChangeNotifier {
  void receiveToken(Auth_manager auth, List<StudentModelSearch> students) {
    _authToken = auth.token;
    __students = students;
  }

  String? _authToken;
  List<StudentModelSearch> __students = [];
  List<StudentModelSimple> _studentsSimple = [];
  StudentModelSearch _singleStudent = StudentModelSearch();
  List<StudentModelSearch> get students => __students;
  List<StudentModelSimple> get studentsSimple => _studentsSimple;
  StudentModelSearch? get singleStudent => _singleStudent;

  get hasmore => _hasMore;
  get pageNumber => _pageNumber;
  get error => _error;
  get loading => _loading;
  get isloading => _isloading;

  bool _hasMore = false;
  int _pageNumber = 1;
  bool _error = false;
  bool _loading = true;

  bool _isloading = true;

  final int _defaultPerPageCount = 15;

  Future<void> add_student(
    String? name,
    String? email,
    String? phone,
    String? school,
    String? note,
    String? city,
    List<String>? groups,
    String? parent,
    String? relationType,
    String? parentPhone,
    String? parentWhatsapp,
    String? gender,
    String? studyType,
    dynamic secondLanguage,
    String? discount,
    String? code,
    String? password,
    String? passwordconfirmation,
    String? parentemail,
    String? parentpassword,
  ) async {
    try {
      Dio dio = Dio();
      String urld = 'https://development.mrsaidmostafa.com/api/students';

      var params = {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'password_confirmation': passwordconfirmation,
        'school': school,
        // 'subject_id': subject,
        'groups': groups,
        'city_id': city,
        'parent': parent,
        'relation_type': relationType,
        'parent_phone': parentPhone,
        'parent_whatsapp': parentWhatsapp,
        'gender': gender,
        'study_type': studyType,
        'discount': discount,
        'code': code,
        'second_language': secondLanguage,
        'parent_email': parentemail,
        'parent_password': parentpassword,
      };
      dio.options.headers["Authorization"] = 'Bearer $_authToken';
      dio.options.headers["Accept"] = 'application/json';
      var response = await dio.post(urld, data: jsonEncode(params));

      final responseData = response.data;
      print(responseData);
      // if (responseData['errors'] != null) {
      //   print('here');
      //   List<String> errors = [];
      //   for (var value in responseData['errors'].values) errors.add(value[0]);
      //   throw HttpException(errors.join('  '));

    } on DioError catch (e) {
      if (e.response!.data['errors'] != null) {
        print(e.response!.data);
        List<String> errors = [];
        for (var value in e.response!.data['errors'].values)
          errors.add(value[0]);
        throw HttpException(errors.join('  '));
      } else {
        print(error);
      }
    }

    notifyListeners();
  }

  Future<void> modify_student(
    String id,
    String? name,
    String? email,
    String? phone,
    String? school,
    String? note,
    String? city,
    List<String>? groups,
    String? parent,
    String? relationType,
    String? parentPhone,
    String? parentWhatsapp,
    String? gender,
    String? studyType,
    String? secondLanguage,
    String? discount,
    String? code,
    String? password,
    String? passwordconfirmation,
  ) async {
    try {
      Dio dio = Dio();
      String urld = 'https://development.mrsaidmostafa.com/api/students/$id';
      print(urld);

      var params = {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'password_confirmation': passwordconfirmation,
        'school': school,
        // 'subject_id': subject,
        'groups': groups,
        'city_id': city,
        'parent': parent,
        'relation_type': relationType,
        'parent_phone': parentPhone,
        'parent_whatsapp': parentWhatsapp,
        'gender': gender,
        'study_type': studyType,
        'discount': discount,
        'code': code,
        'second_language': secondLanguage,
        'note': note
      };
      dio.options.headers["Authorization"] = 'Bearer $_authToken';
      dio.options.headers["Accept"] = 'application/json';
      var response = await dio.put(urld, data: jsonEncode(params));

      final responseData = response.data;
      print(responseData);
      // if (responseData['errors'] != null) {
      //   print('here');
      //   List<String> errors = [];
      //   for (var value in responseData['errors'].values) errors.add(value[0]);
      //   throw HttpException(errors.join('  '));

    } on DioError catch (e) {
      if (e.response!.data['errors'] != null) {
        print(e.response!.data);
        List<String> errors = [];
        for (var value in e.response!.data['errors'].values)
          errors.add(value[0]);
        throw HttpException(errors.join('  '));
      } else {
        print(e);
      }
    }

    notifyListeners();
  }

  Future<void> get_students() async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/students');
    try {
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );
      final responseData = json.decode(response.body);

      List<dynamic> yearsList = responseData['data'];
      var list =
          yearsList.map((data) => StudentModelSearch.fromJson(data)).toList();
      __students = list;
      print(responseData);
      // add exception

    } catch (error) {
      print('students');
      print(error);
    }

    notifyListeners();
  }

  Future<void> getMoreDatafiltered(String filter1) async {
    // print(_pageNumber);
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/students', {
        "group_id": filter1,
        "page": _pageNumber.toString(),
      });
      // print(url);
      // print(_pageNumber);
      //
      print(url);
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );

      final responseData = json.decode(response.body);

      List<dynamic> studentsList = responseData['data'];
      // print(studentsList[0]['groups']);
      // print(StudentModelSearch.fromJson(studentsList[0]).code);
      // __students.add(StudentModelSearch.fromJson(studentsList[0]));

      List<StudentModelSearch> fetchedstudents = studentsList
          .map((data) => StudentModelSearch.fromJson(data))
          .toList();
      _hasMore = fetchedstudents.length == _defaultPerPageCount;
      _loading = false;
      _pageNumber = _pageNumber + 1;

      __students.addAll(fetchedstudents);
    } catch (e) {
      print(e);
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> getMoreDatafilteredId(String filter1) async {
    // print(_pageNumber);
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/students', {
        "id": filter1,
      });
      // print(url);
      // print(_pageNumber);
      //
      print(url);
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );

      final responseData = json.decode(response.body);

      List<dynamic> studentsList = responseData['data'];
      // var fetchedstudents =
      //     studentsList.map((data) => StudentModel.fromJson(data)).toList();
      var fetchedstudent = StudentModelSearch.fromJson(studentsList[0]);

      // _hasMore = fetchedstudents.length == _defaultPerPageCount;
      // _loading = false;
      // _pageNumber = _pageNumber + 1;

      _singleStudent = fetchedstudent;
      print(fetchedstudent.groups);
    } catch (e) {
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  void resetlist() {
    print('object');
    __students = [];
    _loading = true;
    _pageNumber = 1;
    _error = false;
    _isloading = true;
    notifyListeners();
  }

  void setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void seterror(bool value) {
    _error = value;
    notifyListeners();
  }

  Future<List<StudentModelSearch>> searchStudent(String filter1) async {
    try {
      print('cooooooooooooode');
      print(filter1);
      var url = Uri.https('development.mrsaidmostafa.com', '/api/students', {
        "name": filter1,
      });

      print(url);
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );

      final responseData = json.decode(response.body);
      print('coddddddddde');
      print(responseData);
      // print(responseData);
      List<dynamic> studentsList = responseData['data'];
      // print(studentsList[0]);
      // print(studentsList);
      print(StudentModelSearch.fromJson(studentsList[0]));

      List<StudentModelSearch> list = studentsList
          .map((data) => StudentModelSearch.fromJson(data))
          .toList();

      return list;
    } catch (e) {
      print('errrrrrrrrrr');
      print(e);
      throw e;
    }
  }

  Future<List<StudentModelSearch>> searchcodeStudent(String filter2) async {
    try {
      print('cooooooooooooode');
      print(filter2);
      var url = Uri.https('development.mrsaidmostafa.com', '/api/students', {
        "code": filter2,
      });

      print(url);
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );

      final responseData = json.decode(response.body);
      print('coddddddddde');
      print(responseData);
      // print(responseData);
      List<dynamic> studentsList = responseData['data'];
      // print(studentsList[0]);
      // print(studentsList);
      print(StudentModelSearch.fromJson(studentsList[0]));

      List<StudentModelSearch> list = studentsList
          .map((data) => StudentModelSearch.fromJson(data))
          .toList();

      return list;
    } catch (e) {
      print('errrrrrrrrrr');
      print(e);
      throw e;
    }
  }

  void setSingleStudent(StudentModelSearch st) {
    _singleStudent = st;
    notifyListeners();
  }

  Future<AttendGroupStudentModel> getAttendanceStudent(
      String groupid, String stuid) async {
    // print(_pageNumber);
    try {
      var url = Uri.https('development.mrsaidmostafa.com',
          '/api/groups/$groupid/students/$stuid');
      // print(_pageNumber);
      //
      print(url);
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );

      final responseData = json.decode(response.body);
      // print(responseData);
      dynamic groupstudent = responseData['data'];
      // print(studentsList[0]);
      // print(studentsList);
      // print(StudentModelSearch.fromJson(studentsList[0]));

      AttendGroupStudentModel attendance =
          AttendGroupStudentModel.fromJson(groupstudent);

      return attendance;
    } catch (e) {
      // print(e);
      throw e;
    }
  }

  Future<void> getDataSearch(String filter1, String filter2) async {
    // print(_pageNumber);
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/students', {
        "group_id": filter1,
        "name": filter2,
        // "page": _pageNumber.toString(),
      });
      // print(url);
      // print(_pageNumber);
      //
      print(url);
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );

      final responseData = json.decode(response.body);

      List<dynamic> studentsList = responseData['data'];
      // print(studentsList[0]['groups']);
      // print(StudentModelSearch.fromJson(studentsList[0]).code);
      // __students.add(StudentModelSearch.fromJson(studentsList[0]));

      List<StudentModelSearch> fetchedstudents = studentsList
          .map((data) => StudentModelSearch.fromJson(data))
          .toList();
      // _hasMore = fetchedstudents.length == _defaultPerPageCount;
      // _loading = false;
      // _pageNumber = _pageNumber + 1;
      _isloading = false;

      __students = (fetchedstudents);
      notifyListeners();
    } catch (e) {
      print(e);
      // _loading = false;
      // _error = true;
      notifyListeners();
    }

    notifyListeners();
  }
}
