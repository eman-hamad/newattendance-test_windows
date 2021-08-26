import 'dart:convert';
import 'dart:io';

import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/models/stage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StageManager extends ChangeNotifier {
  void receiveToken(Auth_manager auth, List<Stage> stages) {
    authToken = auth.token;
    _stages = stages;
  }

  String? authToken;
  List<Stage> _stages = [];
  List<Stage>? get stages => _stages;
  get hasmore => _hasMore;
  get pageNumber => _pageNumber;
  get error => _error;
  get loading => _loading;

  bool _hasMore = false;
  int _pageNumber = 1;
  bool _error = false;
  bool _loading = true;

  final int _defaultPerPageCount = 15;

  Future<void> get_stages() async {
    var url = Uri.https('development.mrsaidmostafa.com', '/api/stages');
    try {
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $authToken'
        },
      );
      final responseData = json.decode(response.body);

      List<dynamic> stagesList = responseData['data'];
      var list = stagesList.map((data) => Stage.fromJson(data)).toList();
      _stages = list;

      // add exception

    } catch (error) {
      print(error);
    }

    notifyListeners();
  }

  Future<void> getMoreData() async {
    try {
      var url = Uri.https('development.mrsaidmostafa.com', '/api/stages',
          {"page": _pageNumber.toString()});
      var response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $authToken'
        },
      );

      final responseData = json.decode(response.body);

      List<dynamic> yearsList = responseData['data'];
      var fetchedStages =
          yearsList.map((data) => Stage.fromJson(data)).toList();
      _hasMore = fetchedStages.length == _defaultPerPageCount;
      _loading = false;
      _pageNumber = _pageNumber + 1;

      _stages.addAll(fetchedStages);
    } catch (e) {
      _loading = false;
      _error = true;
      notifyListeners();
    }

    notifyListeners();
  }

  void resetlist() {
    _stages = [];
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
