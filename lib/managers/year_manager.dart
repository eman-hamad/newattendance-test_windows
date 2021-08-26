import 'dart:convert';
import 'dart:io';
import 'package:attendance/helper/httpexception.dart';

import 'package:attendance/managers/Auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/models/year.dart';

class YearManager extends ChangeNotifier {
  void receiveToken(Auth_manager auth, List<YearModel> years) {
    _authToken = auth.token;
    _years = years;
  }

  String? _authToken;
  List<YearModel> _years = [];
  List<YearModel> get years => _years;
  get hasmore => _hasMore;
  get pageNumber => _pageNumber;
  get error => _error;
  get loading => _loading;

  bool _hasMore = false;
  int _pageNumber = 1;
  bool _error = false;
  bool _loading = true;

  final int _defaultYearsPerPageCount = 15;

  Future<void> add_year(String name, String stage_id) async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/years');
    try {
      var response = await http.post(
        url,
        body: {'name': name, 'stage_id': stage_id},
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

  Future<void> get_years() async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/years');
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
      var list = yearsList.map((data) => YearModel.fromJson(data)).toList();
      _years = list;

      // add exception

    } catch (error) {
      throw (error);
      // print(error);
    }

    notifyListeners();
  }

//
  Future<void> getMoreData() async {
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/years',
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
          yearsList.map((data) => YearModel.fromJson(data)).toList();
      _hasMore = fetchedYears.length == _defaultYearsPerPageCount;
      _loading = false;
      _pageNumber = _pageNumber + 1;

      _years.addAll(fetchedYears);
    } catch (e) {
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  void resetlist() {
    _years = [];
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

  Future<void> deleteyear(String id) async {
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/years/$id');
      final existingIndex =
          _years.indexWhere((subj) => subj.id.toString() == id);
      var existingyear = _years[existingIndex];
      // print(existingsubject.name);
      _years.removeAt(existingIndex);
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
        _years.insert(existingIndex, existingyear);
        notifyListeners();
        throw HttpException('حاول مره اخري');
      }
    } catch (error) {
      throw (error);
    }
  }

  // void sethasmore(bool value) {
  //   _hasMore = value;
  //   notifyListeners();
  // }

  // void setpagenumber(int value) {
  //   _pageNumber = value;
  //   notifyListeners();
  // }

  // void resetyears() {
  //   _years = [];
  //   notifyListeners();
  // }
}
