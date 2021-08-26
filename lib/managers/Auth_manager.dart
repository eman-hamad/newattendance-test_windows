import 'dart:async';
import 'dart:io';
import 'package:attendance/helper/httpexception.dart';
import 'package:attendance/models/StudentSearchModel.dart';
import 'package:attendance/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:_http';

import 'package:shared_preferences/shared_preferences.dart';

enum user { center, student, assistant, teacher, parent }

class Auth_manager extends ChangeNotifier {
  String? token;
  int? _userId;
  String? _userEmail;
  String? _userPhone;
  String? _type;
  StudentModelSearch? _studentUser;
  TeacherModel? _teacherUser;
  late String _name;
  static String? group__name;
  int? get userid => _userId;
  bool get isLoggedIn => token != null;
  String get name => _name;
  StudentModelSearch? get userstudent => _studentUser;
  TeacherModel? get userteacher => _teacherUser;
  user? get type {
    if (_type == 'center') return user.center;
    if (_type == 'student') return user.student;
    if (_type == 'assistant') return user.assistant;
    if (_type == 'teacher') return user.teacher;
    if (_type == 'parent') return user.parent;
  }

  StudentModelSearch? get studentUser => _studentUser;

  Future<void> login(String email, String password) async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/login');
    try {
      var response = await http.post(
        url,
        body: {'username': email, 'password': password},
        headers: {'Accept': 'application/json'},
      );
      final responseData = json.decode(response.body);
      print(responseData);

      if (responseData['errors'] != null) {
        throw HttpException(responseData['errors']['username'][0]);
      }
      token = responseData['token'];
      _userId = responseData['data']['id'];
      _userEmail = responseData['data']['email'];
      _userPhone = responseData['data']['phone'];
      _name = responseData['data']['name'];
      group__name = _name;
      _type = responseData['data']['type'];
      print(_type);
      print("_name");
      print(group__name);
      print(_type);

      if (_type == 'student') {
        _studentUser = StudentModelSearch.fromJson(responseData['data']);
      }
      if (_type == 'teacher') {
        _teacherUser = TeacherModel.fromJson(responseData['data']);
      }
      if (_type == 'parent') {
        String idstudent = responseData['data']['student']['id'].toString();
        _studentUser = await searchStudent(idstudent, token!);
        _userId = responseData['data']['student']['id'];
      }
    } catch (error) {
      print(error);
      throw (error);
    }

    notifyListeners();
  }

  Future<void> rememberMe() async {
    final prefs = await SharedPreferences.getInstance();

    if (_type == 'student' || _type == 'parent') {
      final userData = json.encode(
        {
          'token': token,
          'userId': _userId,
          'userEmail': _userEmail,
          'userPhone': _userPhone,
          'name': _name,
          'type': _type,
          'student': _studentUser!.toJson()
        },
      );
      prefs.setString('userData', userData);
    }
    if (_type == 'teacher') {
      final userData = json.encode(
        {
          'token': token,
          'userId': _userId,
          'userEmail': _userEmail,
          'userPhone': _userPhone,
          'name': _name,
          'type': _type,
          'teacher': _teacherUser!.toJson()
        },
      );
      prefs.setString('userData', userData);
    }
    if (_type == 'center') {
      final userData = json.encode(
        {
          'token': token,
          'userId': _userId,
          'userEmail': _userEmail,
          'userPhone': _userPhone,
          'name': _name,
          'type': _type,
          // 'student': _studentUser!.toJson()
        },
      );
      prefs.setString('userData', userData);
    }
  }

  void logout() async {
    token = null;
    _userId = null;
    _userEmail = null;
    _userPhone = null;
    _type = null;
    _studentUser = null;
    _teacherUser = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> tryAutoLogin() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData = prefs.getString('userData');
    final data = (json.decode(extractedData!));
    if (data['type'] == 'student' || data['type'] == 'parent') {
      token = data['token'];
      _userId = data['userId'];
      _userPhone = data['userPhone'];
      _userEmail = data['userEmail'];
      _name = data['name'];
      _type = data['type'];
      _studentUser = StudentModelSearch.fromJson(data['student']);
    }
    if (data['type'] == 'teacher') {
      token = data['token'];
      _userId = data['userId'];
      _userPhone = data['userPhone'];
      _userEmail = data['userEmail'];
      _name = data['name'];
      _type = data['type'];
      _teacherUser = TeacherModel.fromJson(data['teacher']);
    }

    if (data['type'] == 'center') {
      token = data['token'];
      _userId = data['userId'];
      _userPhone = data['userPhone'];
      _userEmail = data['userEmail'];
      _name = data['name'];
      _type = data['type'];
      // _studentUser = StudentModelSearch.fromJson(data['student']);
    }

    notifyListeners();
    return true;
  }

  Future<StudentModelSearch> searchStudent(String filter1, String token) async {
    // print(_pageNumber);
    try {
      var url =
          Uri.https('development.mrsaidmostafa.com', '/api/students/$filter1');
      // print(_pageNumber);
      //
      print(url);
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      );

      final responseData = json.decode(response.body);
      // print(responseData);
      dynamic student = responseData['data'];
      // print(studentsList[0]);
      // print(studentsList);
      StudentModelSearch parentStudent = StudentModelSearch.fromJson(student);

      return parentStudent;
    } catch (e) {
      // print(e);
      throw e;
    }
  }
}
