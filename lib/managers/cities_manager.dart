import 'dart:convert';
import 'dart:io';

import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/models/city.dart';
import 'package:attendance/models/stage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/models/year.dart';

class CitiesManager extends ChangeNotifier {
  List<City>? _cities = [];
  List<City>? get cities => _cities;
  get hasmore => _hasMore;
  get pageNumber => _pageNumber;
  get error => _error;
  get loading => _loading;

  bool _hasMore = false;
  int _pageNumber = 1;
  bool _error = false;
  bool _loading = true;

  final int _defaultcitiesPerPageCount = 15;

  Future<void> get_cities() async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/select/cities');
    try {
      var response = await http.get(
        url,
      );
      final responseData = json.decode(response.body);

      List<dynamic> stagesList = responseData['data'];
      var list = stagesList.map((data) => City.fromJson(data)).toList();
      _cities = list;

      // add exception

    } catch (error) {
      print('errorcities');
      print(error);
    }

    notifyListeners();
  }

  Future<void> getMoreData() async {
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/select/cities',
          {"page": _pageNumber.toString()});
      var response = await http.get(
        url,
      );
      // print(url);

      final responseData = json.decode(response.body);

      List<dynamic> cities = responseData['data'];
      var fetchedcities = cities.map((data) => City.fromJson(data)).toList();
      _hasMore = fetchedcities.length == _defaultcitiesPerPageCount;
      _loading = false;
      _pageNumber = _pageNumber + 1;

      _cities!.addAll(fetchedcities);
    } catch (e) {
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  void resetlist() {
    _cities = [];
    _loading = true;
    _pageNumber = 1;
    _error = false;
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
