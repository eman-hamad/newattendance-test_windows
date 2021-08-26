

import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import 'home_data.dart';

abstract class HomeDataRepository {

  Future<int> insertHomeData(HomeData HomeData);

  Future updateHomeData(HomeData HomeData);

  Future deleteHomeData(int HomeDataId);

  Future<List<HomeData>> getAllHomeData();
}


