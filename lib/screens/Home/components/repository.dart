import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import 'home_data.dart';
import 'home_repository.dart';

class SembastHomeDataRepository extends HomeDataRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("HomeData_store");

  @override
  Future<int> insertHomeData(HomeData HomeData) async {
    return await _store.add(_database, HomeData.toMap());
  }

  @override
  Future updateHomeData(HomeData HomeData) async {
    await _store.record(HomeData.id).update(_database, HomeData.toMap());
  }

  @override
  Future deleteHomeData(int HomeDataId) async{
    await _store.record(HomeDataId).delete(_database);
  }

  @override
  Future<List<HomeData>> getAllHomeData() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => HomeData.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}