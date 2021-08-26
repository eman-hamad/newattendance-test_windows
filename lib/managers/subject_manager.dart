import 'dart:convert';
import 'dart:io';
import 'package:attendance/helper/httpexception.dart';

import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubjectManager extends ChangeNotifier {
  void receiveToken(Auth_manager auth, List<SubjectModel> subjects) {
    _authToken = auth.token;
    _subjects = subjects;
  }

  String? _authToken;
  List<SubjectModel>? _subjects = [];
  List<SubjectModel>? get subjects => _subjects;
  // int _page = 0;
  // get page => _page;
  get hasmore => _hasMore;
  get pageNumber => _pageNumber;
  get error => _error;
  get loading => _loading;

  bool _hasMore = false;
  int _pageNumber = 1;
  bool _error = false;
  bool _loading = true;

  final int _defaultYearsPerPageCount = 15;

  Future<void> add_subject(String name, String year_id) async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/subjects');
    try {
      var response = await http.post(
        url,
        body: {'name': name, 'year_id': year_id},
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {}
      // add exception

    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  Future<void> get_subjects() async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/subjects');
    try {
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );
      final responseData = json.decode(response.body);

      List<dynamic> subjectsList = responseData['data'];
      var list =
          subjectsList.map((data) => SubjectModel.fromJson(data)).toList();
      _subjects = list;

      // add exception

    } catch (error) {
      print('errorsubjects');
      print(error);
    }

    notifyListeners();
  }

  Future<void> getMoreData() async {
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/subjects',
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
      var fetchedYears =
          yearsList.map((data) => SubjectModel.fromJson(data)).toList();
      _hasMore = fetchedYears.length == _defaultYearsPerPageCount;
      _loading = false;
      _pageNumber = _pageNumber + 1;

      _subjects!.addAll(fetchedYears);
    } catch (e) {
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> getMoreDatafiltered(String filter) async {
    // print(_pageNumber);
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/subjects', {
        "year_id": filter,
        "page": _pageNumber.toString(),
      });
      //
      // print(url);
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );

      final responseData = json.decode(response.body);

      List<dynamic> yearsList = responseData['data'];
      var fetchedYears =
          yearsList.map((data) => SubjectModel.fromJson(data)).toList();
      _hasMore = fetchedYears.length == _defaultYearsPerPageCount;
      _loading = false;
      _pageNumber = _pageNumber + 1;

      _subjects!.addAll(fetchedYears);
    } catch (e) {
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  void resetlist() {
    _subjects = [];
    _loading = true;
    _pageNumber = 1;
    _error = false;
    // print(_pageNumber);
    notifyListeners();
  }

  // void setpage1() {
  //   _pageNumber = 1;
  //   print(_pageNumber);
  //   notifyListeners();
  // }

  void setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void seterror(bool value) {
    _error = value;
    notifyListeners();
  }

  Future<void> deletesubject(String id) async {
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/subjects/$id');
      final existingIndex =
          _subjects!.indexWhere((subj) => subj.id.toString() == id);
      var existingsubject = _subjects![existingIndex];
      // print(existingsubject.name);
      _subjects!.removeAt(existingIndex);
      // print('here');
      notifyListeners();
      final response = await http.delete(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_authToken'
        },
      );
      print(response.body);
      if (response.statusCode >= 400) {
        // print('asd');
        _subjects!.insert(existingIndex, existingsubject);
        notifyListeners();
        throw HttpException('حاول مره اخري');
      }
    } catch (error) {
      throw (error);
    }
  }
}
