import 'dart:convert';
import 'dart:io';
import 'package:attendance/helper/httpexception.dart';

import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/models/teacher.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherManager extends ChangeNotifier {
  void receiveToken(Auth_manager auth, List<TeacherModel> teachers) {
    _authToken = auth.token;
    _teachers = teachers;
  }

  String? _authToken;
  List<TeacherModel> _teachers = [];
  List<TeacherModel> get teachers => _teachers;
  get hasmore => _hasMore;
  get pageNumber => _pageNumber;
  get error => _error;
  get loading => _loading;

  bool _hasMore = false;
  int _pageNumber = 1;
  bool _error = false;
  bool _loading = true;

  final int _defaultPerPageCount = 15;

  Future<void> add_teacher(
    String? name,
    String? phone,
    String? email,
    String? phone2,
    String? password,
    String? passwordConfirmation,
    String? assistantPhone,
    String? assistantPhone2,
    String? school,
    String? experience,
    String? note,
    String? subject,
    List<String>? years,
    String? cityId,
    String? assiemail,
    String? assispass,
    String? assisname,
  ) async {
    try {
      Dio dio = Dio();
      String urld = 'https://development.mrsaidmostafa.com/api/teachers';
      var params = {
        'name': name,
        'phone': phone,
        'email': email,
        'phone2': phone2,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'assistant_phone': assistantPhone,
        'assistant_phone2': assistantPhone2,
        'school': school,
        'experience': experience,
        'note': note,
        'subject_id': subject,
        'years': years,
        'city_id': cityId,
        'assistant_email': assiemail,
        'assistant_password': assispass,
        'assistant_name': assisname,
      };
      dio.options.headers["Authorization"] = 'Bearer $_authToken';
      dio.options.headers["Accept"] = 'application/json';

      var response = await dio.post(urld, data: jsonEncode(params));

      final responseData = response.data;
      print(responseData);

      // if (responseData['errors'] != null) {
      //   List<String> errors = [];
      //   for (var value in responseData['errors'].values) errors.add(value[0]);
      //   throw HttpException(errors.join('  '));
      // }
    } on DioError catch (e) {
      if (e.response!.data['errors'] != null) {
        print(e.response!.data);
        List<String> errors = [];
        for (var value in e.response!.data['errors'].values)
          errors.add(value[0]);
        throw HttpException(errors.join('  '));
      } else {
        throw (error);
      }
    }

    notifyListeners();
  }

  Future<void> get_teachers() async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/teachers');
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
      var list = yearsList.map((data) => TeacherModel.fromJson(data)).toList();
      _teachers = list;
      print(responseData);
      // add exception

    } catch (error) {
      print('teacherall');
      print(error);
    }

    notifyListeners();
  }

  Future<void> getMoreData() async {
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/teachers',
          {"page": _pageNumber.toString()});
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );

      final responseData = json.decode(response.body);

      List<dynamic> yearsList = responseData['data'];
      var fetched =
          yearsList.map((data) => TeacherModel.fromJson(data)).toList();
      _hasMore = fetched.length == _defaultPerPageCount;
      _loading = false;
      _pageNumber = _pageNumber + 1;

      _teachers.addAll(fetched);
    } catch (e) {
      print(e);
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> getMoreDatafiltered(String filter1, String filter2) async {
    // print(_pageNumber);
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/teachers', {
        "year_id": filter1,
        "subject_id": filter2,
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

      List<dynamic> teachersList = responseData['data'];
      var fetchedsubjects =
          teachersList.map((data) => TeacherModel.fromJson(data)).toList();
      _hasMore = fetchedsubjects.length == _defaultPerPageCount;
      _loading = false;
      _pageNumber = _pageNumber + 1;

      _teachers.addAll(fetchedsubjects);
    } catch (e) {
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  void resetlist() {
    _teachers = [];
    _loading = true;
    _pageNumber = 1;
    _error = false;
    _loading = true;
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
}
