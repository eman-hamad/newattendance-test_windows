import 'dart:convert';
import 'dart:io';
import 'package:attendance/helper/httpexception.dart';
import 'package:attendance/models/StudentModelCompare.dart';
import 'package:attendance/models/appointment.dart';
import 'package:attendance/models/groupmodelsimple.dart';
import 'package:dio/dio.dart';

import 'package:attendance/managers/Auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GroupManager extends ChangeNotifier {
  void receiveToken(Auth_manager auth, List<GroupModelSimple> groups) {
    _authToken = auth.token;
    _groups = groups;
  }

  String? _authToken;
  List<StudentModelCompare> _students_compare = [];
  List<StudentModelCompare>? get students_compare => _students_compare;

  static List<GroupModelSimple> _groups_offline = [];
  List<GroupModelSimple> _groups = [];
  static var group_info ;

  List<AppointmentModel> _group_students = [];
  List<AppointmentModel> get group_students => _group_students;
  static List<GroupModelSimple> get groupsoffline => _groups_offline;
  List<GroupModelSimple> get groups => _groups;
  get hasmore => _hasMore;
  get pageNumber => _pageNumber;
  get error => _error;
  get loading => _loading;

  bool _hasMore = false;
  int _pageNumber = 1;
  bool _error = false;
  bool _loading = true;
  final int _defaultGroupsPerPageCount = 15;
  // var lesson__id = [];
  // var i = 0;
  Future<void> add_compare(
      lesson__id,
      student_absence,
      // String? degree,
      // // String? year,
      // String? student_id,
      int? url
      // String? teacher,
      // List<String>? day,
      // List<String>? time,
      ) async {
    try {
      Dio dio = Dio();
      String urld =
          'https://development.mrsaidmostafa.com/api/groups/$url/compare';
      print(urld);

      var params = {
        "appointments": [
          // {"appointment_id": lesson__id[i], "case": "attend"},
          for (var i = 0; i < lesson__id.length; i++)
            {"appointment_id": lesson__id[i], "case": student_absence[i]},
        ]
      };
      print('e lesson__idddddddddddddddd');
      print(lesson__id);
      print('e student_absenceeeeeeee');
      print(student_absence);

      dio.options.headers["Authorization"] = 'Bearer $_authToken';
      dio.options.headers["Accept"] = 'application/json';

      var response = await dio.post(urld, data: jsonEncode(params));
      print(response);

      final responseData = response.data;
      print('responseDataaaaaaaaaaaaaaaaaaaaa');
      print(responseData);

      // if (responseData['errors'] != null) {
      //   print(responseData['errors']);
      //   List<String> errors = [];
      //   for (var value in responseData['errors'].values) errors.add(value[0]);
      //   throw HttpException(errors.join('  '));
      //}
      List students = responseData['data']['students'];
      print('students');
      print(students);

      List<StudentModelCompare> list =
          students.map((data) => StudentModelCompare.fromJson(data)).toList();
      _students_compare = list;
      print("list");
      print(list);
      print(_students_compare[1].id);
      _loading = false;
    } catch (error) {
      print(error);
      throw (error);
    }

    notifyListeners();
  }

  Future<void> add_degree(
      String? degree,
      // String? year,
      String? student_id,
      String? url
      // String? teacher,
      // List<String>? day,
      // List<String>? time,
      ) async {
    try {
      Dio dio = Dio();
      String urld =
          'https://development.mrsaidmostafa.com/api/degree/appointments/$url';
      print(urld);
      var params = {
        'degree': degree,
        'student_id': student_id,
      };

      dio.options.headers["Authorization"] = 'Bearer $_authToken';
      dio.options.headers["Accept"] = 'application/json';

      var response = await dio.post(urld, data: jsonEncode(params));
      print(response);

      final responseData = response.data;
      print(responseData);

      if (responseData['errors'] != null) {
        print(responseData['errors']);
        List<String> errors = [];
        for (var value in responseData['errors'].values) errors.add(value[0]);
        throw HttpException(errors.join('  '));
      }
    } catch (error) {
      print(error);
      throw (error);
    }

    notifyListeners();
  }

  // Future<void> add_degree_off(
  //     var? degree,
  //     // String? year,
  //     var ? student_id,
  //     String? url
  //     // String? teacher,
  //     // List<String>? day,
  //     // List<String>? time,
  //     ) async {
  //   try {
  //     Dio dio = Dio();
  //     String urld =
  //         'https://development.mrsaidmostafa.com/api/degree/appointments/$url';
  //     print(urld);
  //     var params = {
  //       'degree': degree,
  //       'student_id': student_id,
  //     };

  //     dio.options.headers["Authorization"] = 'Bearer $_authToken';
  //     dio.options.headers["Accept"] = 'application/json';

  //     var response = await dio.post(urld, data: jsonEncode(params));
  //     print(response);

  //     final responseData = response.data;
  //     print(responseData);

  //     if (responseData['errors'] != null) {
  //       print(responseData['errors']);
  //       List<String> errors = [];
  //       for (var value in responseData['errors'].values) errors.add(value[0]);
  //       throw HttpException(errors.join('  '));
  //     }
  //   } catch (error) {
  //     print(error);
  //     throw (error);
  //   }

  //   notifyListeners();
  // }

  Future<void> addgroup(
    String? name,
    String? year,
    String? subject,
    String? teacher,
    List<String>? day,
    List<String>? time,
  ) async {
    try {
      Dio dio = Dio();
      String urld = 'https://development.mrsaidmostafa.com/api/groups';
      print(urld);
      var params = {
        'name': name,
        'year_id': year,
        'subject_id': subject,
        'teacher_id': teacher,
        'day': day,
        'time': time
      };

      dio.options.headers["Authorization"] = 'Bearer $_authToken';
      dio.options.headers["Accept"] = 'application/json';

      var response = await dio.post(urld, data: jsonEncode(params));
      print(response);

      final responseData = response.data;
      print(responseData);

      if (responseData['errors'] != null) {
        print(responseData['errors']);
        List<String> errors = [];
        for (var value in responseData['errors'].values) errors.add(value[0]);
        throw HttpException(errors.join('  '));
      }
    } catch (error) {
      print(error);
      throw (error);
    }

    notifyListeners();
  }

  Future<void> get_groups() async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/groups');
    try {
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );
      final responseData = json.decode(response.body);

      List<dynamic> stagesList = responseData['data'];
      var list =
          stagesList.map((data) => GroupModelSimple.fromJson(data)).toList();
      _groups = list;
      print('groups');
      print(_groups[8].name);
      // _loading = false;
      // add exception

    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  Future<void> get_groups_offline() async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/groups');
    try {
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );
      final responseData = json.decode(response.body);

      List<dynamic> stagesList = responseData['data'];
      var list =
          stagesList.map((data) => GroupModelSimple.fromJson(data)).toList();
      _groups_offline = list;
      print('groups');
      print(_groups_offline[8].name);
      // _loading = false;
      // add exception

    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  Future<void> get_group_students(int id) async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/groups/$id');
    try {
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );
      final responseData = json.decode(response.body);
      print('responseDataaaaaa');
      print(responseData);
      List<dynamic> stagesList = responseData['data']['appointments'];
      print('stagesListtttttttttt');
      print(stagesList);
      var list =
          stagesList.map((data) => AppointmentModel.fromJson(data)).toList();
      _group_students = list;
      _loading = false;
      // add exception
      //  for (var i = 0; i < stagesList.length; i++) {
      //   lesson__id.add(stagesList[i]['id']);
      //   print('iddddddddddddddddd');
      //   print(lesson__id);
      // }
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  Future<void> get_group_offline(int id) async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/groups/$id');
    try {
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );
      final responseData = json.decode(response.body);
      // print('responseDataaaaaa');
      // print(responseData);
      var stages = responseData['data'];
      print('one group offline');
      print(stages);
      group_info = stages;
      // var list =
      //     stagesList.map((data) => AppointmentModel.fromJson(data)).toList();
      // _group_students = list;
      _loading = false;
      // add exception
      //  for (var i = 0; i < stagesList.length; i++) {
      //   lesson__id.add(stagesList[i]['id']);
      //   print('iddddddddddddddddd');
      //   print(lesson__id);
      // }
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  Future<void> getMoreData() async {
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/groups',
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
      var fetchedGroups =
          yearsList.map((data) => GroupModelSimple.fromJson(data)).toList();
      _hasMore = fetchedGroups.length == _defaultGroupsPerPageCount;
      _loading = false;
      _pageNumber = _pageNumber + 1;

      _groups.addAll(fetchedGroups);
    } catch (e) {
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> getMoreDatafiltered(
      String filter1, String filter2, String filter3) async {
    // print(_pageNumber);
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/groups', {
        "year_id": filter1,
        "subject_id": filter2,
        "teacher_id": filter3,
        "page": _pageNumber.toString(),
      });
      print(url);
      print(_pageNumber);
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
      print('responseDataaaaaaaaaaaa');
      print(responseData);
      List<dynamic> groupsList = responseData['data'];
      print('groupsListtttttttttttt');
      print(groupsList[0]['id']);

      var fetchedgroups =
          groupsList.map((data) => GroupModelSimple.fromJson(data)).toList();
      _hasMore = fetchedgroups.length == _defaultGroupsPerPageCount;
      _loading = false;
      _pageNumber = _pageNumber + 1;

      _groups.addAll(fetchedgroups);
    } catch (e) {
      print(e);
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  void resetlist() {
    _groups = [];
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
