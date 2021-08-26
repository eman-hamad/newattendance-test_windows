import 'package:attendance/screens/Home/components/home_repository.dart';
import 'package:attendance/screens/Home/components/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class Init {
  static Future initialize() async {
    await _initSembast();
   await _registerRepositories();
  }

  static Future _initSembast() async {
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    final databasePath = join(appDir.path, "home.db");
    final database = await databaseFactoryIo.openDatabase(databasePath);
    GetIt.I.registerSingleton<Database>(database);
  }

  static _registerRepositories() {
    // GetIt s1 = GetIt.instance;
    GetIt locator = GetIt.instance;
    locator.registerLazySingleton<HomeDataRepository>(
        () => SembastHomeDataRepository());
  }
}
