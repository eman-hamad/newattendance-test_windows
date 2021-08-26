// import 'dart:html';

import 'dart:async';
import 'dart:math';
import 'package:attendance/helper/httpexception.dart';
import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/managers/Appointment_manager.dart';
import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/managers/group_manager.dart';
import 'package:attendance/managers/subject_manager.dart';
import 'package:attendance/managers/teacher_manager.dart';
import 'package:attendance/managers/year_manager.dart';
import 'package:attendance/models/teacher.dart';
import 'package:attendance/screens/Home/components/home_repository.dart';
import 'package:attendance/screens/Home/components/init.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:moor/moor.dart' as prefix;
// import 'package:sqflite_common/sqlite_api.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// part 'example.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'dart:io';
// import 'package:sqlite3/sqlite3.dart' as prefix;
// import 'package:path/path.dart';
import 'package:provider/provider.dart';
//  import 'package:sqflite/sqflite.dart';

// import 'package:sqflite_common/sqlite_api.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../constants.dart';
import '../Home_Screen.dart';
import 'home_data.dart';

List<HomeData> home_data = [];
List teacher_no_dublicate = [];
List class_no_dublicate = [];
List home_no_dublicate = [];
List group_no_dublicate = [];
List subject_no_dublicate = [];
bool no_internet = false;
List my_year_list = [];
List my_appointment_list = [];
List my_teacher_list = [];
List my_group_list = [];
List my_subject_list = [];
// Database? database;
String path = '';
late String year_id_selected;
String yearname = 'السنه الدراسيه';
late String subjectId_selected;
String subjectname = 'الماده الدراسيه';
late String teacher_id_selected;
String teachername = 'المدرس';
late String group_id_selected;
String group_name = 'المجموعه';
int group_id = 0;
String? app_id_selected;
String app_name = 'اختر حصه';

class Choices extends StatefulWidget {
  const Choices({
    Key? key,
    required this.size,
    this.usser,
    this.teacher,
  }) : super(key: key);

  final Size size;
  static int my_group = group_id;
  static String mygroup_name = group_name;

  final user? usser;
  final TeacherModel? teacher;
  @override
  _ChoicesState createState() => _ChoicesState();
}

// late String year_id_selected;
// String yearname = 'السنه الدراسيه';
// late String subjectId_selected;
// String subjectname = 'الماده الدراسيه';
// late String teacher_id_selected;
// String teachername = 'المدرس';
// late String group_id_selected;
// String group_name = 'المجموعه';
// late String app_id_selected;
// String app_name = 'اختر حصه';

late String scanResult_code;

class _ChoicesState extends State<Choices> {
  final Future _init = Init.initialize();
  HomeDataRepository _dataRepository = GetIt.I.get();
  List<HomeData> _homedata = [];
  // static late ConnectivityResult _connectionStatus;
  // Connectivity? connectivity;
  // StreamSubscription<ConnectivityResult>? subscription;
  bool check_connectivity(context) {
    setState(() {
      Provider.of<InternetConnectionStatus>(context);
    });
    if (Provider.of<InternetConnectionStatus>(context) ==
        InternetConnectionStatus.disconnected) {
      return false;
      //print('no interrrnet');
    } else {
      // print('yes interrrnet');
      return true;
    }

    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.wifi) {
    //   return true;
    // } else {
    //   setState(() {
    //     no_internet = true;
    //   });
    //   return false;
    // }
  }

  ScrollController _sc1 = new ScrollController();
  ScrollController _sc2 = new ScrollController();
  ScrollController _sc3 = new ScrollController();
  ScrollController _sc4 = new ScrollController();
  void dispose() {
    _sc1.dispose();
    _sc2.dispose();
    _sc3.dispose();

    super.dispose();
  }

  bool _isloadingyears = true;
  bool _isloadingsubjects = false;
  bool _isloadingteachers = false;
  bool _isloadinggroups = false;
  bool _isloadingappointment = false;
  bool _scanloading = false;
  bool _isinit = true;

  _loadData() async {
    // _addData();
    //  for (var i = 0; i < home_data.length;i++) {
    //   _deleteData(home_data[i]!.id!);
    // }
    home_data = await _dataRepository.getAllHomeData();
    setState(() => _homedata = home_data);

    // for (var i = 0; i < home_data.length; i++) {
    //  _homedata[i] = home_data[i];
    //     print(home_data[i].classname);

    // }
    // print('my hommmmmmmmmmme1');
    // for (var i = 0; i < home_data.length; i++) {
    //   if(home_data[i].year==1){
    //   print(home_data[i].classname);
    //   }
    // }
  }

  _addData(String _year, String _subject, String _teacher, String _groupname,
      String _classname) async {
    // final list = ["apple", "orange", "chocolate"]..shuffle();
    final year = "$_year";
    final subject = "$_subject";
    final teacher = "$_teacher";
    final groupname = "$_groupname";
    final classname = "$_classname";
    final newHomeData = HomeData(
        year: year,
        subject: subject,
        teacher: teacher,
        groupname: groupname,
        classname: classname);
    await _dataRepository.insertHomeData(newHomeData);
    // _loadData();
    // print('my hommmmmmmmmmme1');
    // for (var i = 0; i < home_data.length; i++) {
    //   if (home_data[i].year == 'أولي ثانوي') {
    //     print(home_data[i].classname);
    //   }
    // }
  }

  _deleteData(HomeData data) async {
    await _dataRepository.deleteHomeData(data.id!);
    _loadData();
  }

  _editData(HomeData data) async {
    final updatedData = data.copyWith(year: data.classname! + "j");
    await _dataRepository.updateHomeData(updatedData);
    _loadData();
  }

  void create_table() async {
    // await deleteDatabase(path);
    // var databasesPath = await getDatabasesPath();
    // path = join(databasesPath, 'home.db');

    //await openDatabase(path, version: 1,
    //     onCreate: (Database db, int version) async {
    // Init ffi loader if needed.
    //   sqfliteFfiInit();

    //   var databaseFactory = databaseFactoryFfi;
    //   var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    //   await db.execute('''
    // CREATE TABLE Product (
    //     id INTEGER PRIMARY KEY,
    //     title TEXT
    // )
    // ''');
    //   print('new_databassssssssssekkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    //   await db.insert('Product', <String, Object?>{'title': 'Product 1'});
    //   await db.insert('Product', <String, Object?>{'title': 'Product 1'});
    //   print('new_databassssssssssellllllllllllllllllllllllllllllllllll');
    //   var result = await db.query('Product');
    //   print('new_databasssssssssse;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
    //   print(result);
    //   // prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]
    //   await db.close();
    // db.execute(
    //     'CREATE TABLE Homedata (id INTEGER PRIMARY KEY,year STRING, subject STRING ,teacher STRING ,groupname STRING ,classname STRING)');
    // });

    print('hhhhhhhhhhhhhhhhhhhhhhhhha');
    var dir = await getApplicationDocumentsDirectory();
// make sure it exists
    await dir.create(recursive: true);
// build the database path
    var dbPath = join(dir.path, 'my_database.db');
    final db = await databaseFactoryIo.openDatabase(dbPath);
    print('hhhhhhhhhhhhhhhhhhhhhhhhhc');
    var store = intMapStoreFactory.store('id');
    print('hhhhhhhhhhhhhhhhhhhhhhhhhb');
    var key = await store.add(db, {'name': 'ugly', 'yy': 'jj', 'name': 'ugly'});
    print('hhhhhhhhhhhhhhhhhhhhhhhhhcc');
    var record = await (store.record(key).getSnapshot(db)
        as FutureOr<RecordSnapshot<int, Map<String, Object>>>);
    record =
        (await store.find(db, finder: Finder(filter: Filter.byKey(record.key))))
            .first as RecordSnapshot<int, Map<String, Object>>;
    print('hhhhhhhhhhhhhhhhhhhhhhhhh');
    print(record);
    var records = (await (store.find(db,
            finder: Finder(filter: Filter.matches('name', '^ugly')))
        as FutureOr<List<RecordSnapshot<int, Map<String, Object>>>>));
    for (var i = 0; i < records.length; i++) {
      print(records);
    }
  }

  void add_record(String year, String subject, String teacher, String groupname,
      String classname) async {
    // await database!.transaction((txn) async {
    // final id1 = db.prepare(
    //     'INSERT INTO Homedata(year,subject,teacher,groupname,classname)VALUES("$year","$subject","$teacher","$groupname","$classname")');
    // print('inserted1: $id1');
    // count_deree + 1;

    //

    // // Update some record
    // if (count_deree > 1) {
    //   int count = await database.rawUpdate(
    //       'UPDATE Test SET degree = ?, id_value = ? WHERE id_value = ?',
    //       ['$result', '$Student__id', '$Student__id']);
    //   print('updated: $count');
    // }

    // Get the records
    // final list = db.select('SELECT * FROM Homedata');
    // final year_list = db.select('SELECT DISTINCT year FROM Homedata ');
    // my_year_list = year_list as List;

    // id_list = await database.rawQuery('SELECT id_value FROM Test');

    // print('sqflite degreeeeeeeeeee');
    // print(year_list);
    // print('sqflite listttttttttttttttttttttttttt');
    // print(list);

    //await deleteDatabase(path);
    // print('sqflite subject_list listttttttttttttttttttttttttt');
    // print(subject_list);
  }

  @override
  void initState() {
    //print('my hommmmmmmmmmme');
    // print(_homedata[1].year);
    // connectivity = new Connectivity();
    // subscription = connectivity!.onConnectivityChanged
    //     .listen((ConnectivityResult myresult) {
    //   _connectionStatus = myresult;
    //   print('_connectionStatus');
    //   print(_connectionStatus);
    //   if (myresult == ConnectivityResult.wifi)
    //   // ||
    //   //     result == ConnectivityResult.mobile)
    //   {
    //     setState(() {});
    //   }
    // });
    Future.delayed(Duration.zero, () async {
      yearname = 'السنه الدراسيه';
      subjectname = 'الماده الدراسيه';
      teachername =
          widget.usser != user.teacher ? 'المدرس' : widget.teacher!.name!;
      if (widget.usser == user.teacher) {
        teacher_id_selected = widget.teacher!.id!.toString();
      }
      group_name = 'المجموعه';
      app_name = 'الحصه';
      Provider.of<GroupManager>(this.context, listen: false).resetlist();
      Provider.of<TeacherManager>(this.context, listen: false).resetlist();
      // Provider.of<YearManager>(context, listen: false).resetlist();
      Provider.of<SubjectManager>(this.context, listen: false).resetlist();
      Provider.of<YearManager>(this.context, listen: false).resetlist();
      try {
        await Provider.of<YearManager>(this.context, listen: false)
            .getMoreData()
            .then((value) {
          setState(() {
            _isloadingyears = false;
          });
        });
      } catch (e) {}
      if (!mounted) return;
    });

    _sc1.addListener(
      () {
        if (_sc1.position.pixels == _sc1.position.maxScrollExtent) {
          Provider.of<YearManager>(this.context, listen: false).getMoreData();
        }
      },
    );
    _sc2.addListener(
      () {
        if (_sc2.position.pixels == _sc2.position.maxScrollExtent) {
          Provider.of<SubjectManager>(this.context, listen: false)
              .getMoreDatafiltered(year_id_selected.toString());
        }
      },
    );
    _sc3.addListener(
      () {
        if (_sc3.position.pixels == _sc3.position.maxScrollExtent) {
          Provider.of<TeacherManager>(this.context, listen: false)
              .getMoreDatafiltered(year_id_selected, subjectId_selected);
        }
      },
    );
    _sc4.addListener(
      () {
        if (_sc4.position.pixels == _sc4.position.maxScrollExtent) {
          Provider.of<GroupManager>(this.context, listen: false)
              .getMoreDatafiltered(
                  year_id_selected, subjectId_selected, teacher_id_selected);
        }
      },
    );

    Future.delayed(Duration.zero, () async {
      try {
        GroupManager group_manager = new GroupManager();
        await Provider.of<GroupManager>(this.context, listen: false)
            .get_groups_offline()
            .then((value) {
          // print('group name');
          print('group nametttttttttttttt');
          print(GroupManager.groupsoffline.length);
          //print(group_manager.groups);
          setState(() {
            _isloadingyears = false;
          });
        });
      } catch (e) {}
    });
    //
    print('GroupManager.groupsoffline.length');
    print(GroupManager.groupsoffline.length);
    for (var i = 0; i < GroupManager.groupsoffline.length; i++) {
      print('group nameee');
      print(GroupManager.groupsoffline[i].id);

      Future.delayed(Duration.zero, () async {
        try {
          GroupManager group_manager = new GroupManager();
          await Provider.of<GroupManager>(this.context, listen: false)
              .get_group_offline(GroupManager.groupsoffline[i].id!)
              .then((value) {
            print('group data');
            print(GroupManager.group_info['name']);
            setState(() {
              _isloadingyears = false;
            });
            for (var j = 0;
                j < GroupManager.group_info['appointments'].length;
                j++) {
              // add_record(
              //   GroupManager.groupsoffline[i].year!.name!,
              //   GroupManager.groupsoffline[i].subject!.name!,
              //   GroupManager.groupsoffline[i].teacher!.name!,
              //   GroupManager.groupsoffline[i].name!,
              //   GroupManager.group_info['appointments'][j]['name'],
              // );
              _addData(
                GroupManager.groupsoffline[i].year!.name!,
                GroupManager.groupsoffline[i].subject!.name!,
                GroupManager.groupsoffline[i].teacher!.name!,
                GroupManager.groupsoffline[i].name!,
                GroupManager.group_info['appointments'][j]['name'],
              );
            }
          });
          print('NO OF CLASSES');
          print(GroupManager.group_info['appointments'].length);
          // for (var j = 0;
          //     j < GroupManager.group_info['appointments'].length;
          //     j++) {
          // add_record(
          //   GroupManager.group_info['year']['name'],
          //   GroupManager.group_info['subject']['name'],
          //   GroupManager.group_info['teacher']['name'],
          //   GroupManager.group_info['name'],
          //   GroupManager.group_info['appointments'][0]['name'],
          // );
          // }

          // print('group name');
          // print(await GroupManager.groupsoffline);
        } catch (e) {}
      });
    }
    print('_homedataaaaaaaaaaaa');
    print(_homedata);
    print('_homedataaaaaaaaaaaa');
    // print(home_data[0].year);
    //  for (var i = 0; i < home_data.length; i++) {
    //   if (home_data[i].year == 'أولي ثانوي') {

    // print('gg'+home_data[0].);
    //   }
    //  }
    // create_table();
    // add_record(

    //       //GroupManager.group_info['year']['name'],
    //     //  GroupManager.group_info['subject']['name'],
    //       //GroupManager.group_info['teacher']['name'],
    //       //GroupManager.group_info['name'],
    //        GroupManager.group_info['appointments'][0]['name'],

    //      );
//  add_record(

//            GroupManager.group_info['year']['name'],
//             GroupManager.group_info['subject']['name'],
//             GroupManager.group_info['teacher']['name'],
//             GroupManager.group_info['name'],
//             GroupManager.group_info['appointments'][j]['name'],

//            );
    super.initState();
  }

  bool _loadingscann = false;
  List<String> formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat('hh:mm'); //"6:00 AM"
    final dateformate = DateFormat('y-M-d');
    return [format.format(dt), dateformate.format(dt)];
  }

  void _modalBottomSheetMenusubject(BuildContext context) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 250.0,
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbackgroundColor1,
                  ),
                  child: Center(
                    child: Text(
                      'الماده الدراسيه',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GE-bold',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Consumer<SubjectManager>(
                      builder: (_, subjectmanager, child) {
                        if (subjectmanager.subjects!.isEmpty) {
                          if (subjectmanager.loading) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ));
                          } else if (subjectmanager.error) {
                            return Center(
                                child: InkWell(
                              onTap: () {
                                subjectmanager.setloading(true);
                                subjectmanager.seterror(false);
                                Provider.of<SubjectManager>(context,
                                        listen: false)
                                    .getMoreDatafiltered(
                                        year_id_selected.toString());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text("error please tap to try again"),
                              ),
                            ));
                          }
                        } else {
                          return ListView.builder(
                            controller: _sc2,
                            itemCount: subjectmanager.subjects!.length +
                                (subjectmanager.hasmore ? 1 : 0),
                            itemBuilder: (BuildContext ctxt, int index) {
                              if (index == subjectmanager.subjects!.length) {
                                if (subjectmanager.error) {
                                  return Center(
                                      child: InkWell(
                                    onTap: () {
                                      subjectmanager.setloading(true);
                                      subjectmanager.seterror(false);
                                      Provider.of<SubjectManager>(context,
                                              listen: false)
                                          .getMoreDatafiltered(
                                              year_id_selected.toString());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child:
                                          Text("error please tap to try again"),
                                    ),
                                  ));
                                } else {
                                  return Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: CircularProgressIndicator(),
                                  ));
                                }
                              }

                              return GestureDetector(
                                onTap: () async {
                                  Provider.of<TeacherManager>(context,
                                          listen: false)
                                      .resetlist();
                                  setState(() {
                                    subjectId_selected = subjectmanager
                                        .subjects![index].id
                                        .toString();
                                    subjectname =
                                        subjectmanager.subjects![index].name!;
                                    subject_level = true;
                                    teacher_level = widget.usser != user.teacher
                                        ? false
                                        : true;
                                    group_level = false;
                                    _isloadingteachers =
                                        widget.usser != user.teacher
                                            ? true
                                            : false;
                                    if (widget.usser == user.teacher) {
                                      _isloadinggroups = true;
                                    }
                                    teachername = widget.usser != user.teacher
                                        ? 'المدرس'
                                        : widget.teacher!.name!;
                                    group_name = 'المجموعه';
                                    app_name = 'الحصه';
                                  });
                                  Provider.of<AppStateManager>(context,
                                          listen: false)
                                      .setHomeOptions(false);
                                  Navigator.pop(context);

                                  widget.usser != user.teacher
                                      ? await Provider.of<TeacherManager>(
                                              context,
                                              listen: false)
                                          .getMoreDatafiltered(year_id_selected,
                                              subjectId_selected)
                                          .then((value) {
                                          setState(() {
                                            _isloadingteachers = false;
                                          });
                                        })
                                      : await Provider.of<GroupManager>(context,
                                              listen: false)
                                          .getMoreDatafiltered(
                                              year_id_selected,
                                              subjectId_selected,
                                              teacher_id_selected)
                                          .then((value) {
                                          setState(() {
                                            _isloadinggroups = false;
                                          });
                                        });
                                },
                                child: ListTile(
                                  title: Text(
                                      subjectmanager.subjects![index].name!),
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _modalBottomSheetMenuyearOffline(BuildContext context) {
    _loadData();
    for (var i = 0; i < home_data.length; i++) {
      if (!home_no_dublicate.contains(home_data[i].year)) {
        home_no_dublicate.add(home_data[i].year!);
        print('sqflite subject');
        print(home_no_dublicate);
      }
    }
    print('sqflite subject');
    print('_homedata[0].classname');
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              height: 250.0,
              color: Colors.transparent,
              child: Column(children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbuttonColor3,
                  ),
                  child: Center(
                    child: Text(
                      'السنه الدراسيه',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GE-bold',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: ListView.separated(
                      separatorBuilder: (BuildContext ctxt, int index) =>
                          Divider(
                            color: Colors.grey,
                            height: 2,
                          ),
                      itemCount: home_no_dublicate.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                              onTap: () async {
                                Provider.of<SubjectManager>(context,
                                        listen: false)
                                    .resetlist();
                                setState(() {
                                  //year_id_selected =
                                  yearname = home_no_dublicate[index]!;
                                  year_level = true;
                                  subject_level = false;
                                  teacher_level = false;
                                  group_level = false;
                                  _isloadingsubjects = true;
                                  subjectname = 'الماده الدراسيه';
                                  teachername = widget.usser != user.teacher
                                      ? 'المدرس'
                                      : widget.teacher!.name!;
                                  group_name = 'المجموعه';
                                  app_name = 'الحصه';
                                });
                                Navigator.pop(context);
                                Provider.of<AppStateManager>(context,
                                        listen: false)
                                    .setHomeOptions(false);
                                // final subject_list = db.select(
                                //     'SELECT DISTINCT subject FROM Homedata where year LIKE "%${my_year_list[index]['year']}%" ');
                                // my_subject_list = subject_list as List;
                                // await Provider.of<SubjectManager>(context,
                                //         listen: false)
                                //     .getMoreDatafiltered(
                                //         year_id_selected.toString())
                                //     .then((value) {
                                //   setState(() {
                                //     _isloadingsubjects = false;
                                //   });
                                // });
                                //  subject_list =  await database!.rawQuery('SELECT DISTINCT year FROM Homedata ');
                                // id_list = await database.rawQuery('SELECT id_value FROM Test');
                                // _loadData();
                                print('sqflite subject');
                                print('_homedata[0].classname');
                                // print(subject_list);
                              },
                              child: Text(home_no_dublicate[index]!)),
                        );
                      }),
                ))
              ]));
        });
  }

  void _modalBottomSheetMenuSubjectOffline(BuildContext context) {
    _loadData();
    subject_no_dublicate = [];
    for (var i = 0; i < home_data.length; i++) {
      
      if (!subject_no_dublicate.contains(home_data[i].subject) &&
          home_data[i].year == '${yearname}') {
        subject_no_dublicate.add(home_data[i].subject!);
        print('sqflite subject');
        print(home_no_dublicate);
      }
    }
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              height: 250.0,
              color: Colors.transparent,
              child: Column(children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbackgroundColor1,
                  ),
                  child: Center(
                    child: Text(
                      'المادة الدراسية',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GE-bold',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: ListView.separated(
                      separatorBuilder: (BuildContext ctxt, int index) =>
                          Divider(
                            color: Colors.grey,
                            height: 2,
                          ),
                      itemCount: subject_no_dublicate.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                              onTap: () async {
                                Provider.of<TeacherManager>(context,
                                        listen: false)
                                    .resetlist();
                                setState(() {
                                  //year_id_selected =
                                  subjectname = subject_no_dublicate[index];
                                  year_level = true;
                                  subject_level = true;
                                  teacher_level = false;
                                  group_level = false;
                                  _isloadingsubjects = false;
                                  _isloadingteachers = true;
                                  teachername = 'المدرس';
                                  // group_name = widget.usser != user.
                                  //     ? 'المدرس'
                                  //     : widget.teacher!.name!;
                                  group_name = 'المجموعه';
                                  app_name = 'الحصه';
                                });
                                Navigator.pop(context);
                                Provider.of<AppStateManager>(context,
                                        listen: false)
                                    .setHomeOptions(false);

                                ///
                                // Provider.of<TeacherManager>(context,
                                //         listen: false)
                                //     .resetlist();
                                // setState(() {
                                //   // subjectId_selected =
                                //   // subjectmanager
                                //   //     .subjects![index].id
                                //   //     .toString();

                                //   subject_level = true;
                                //   teacher_level = widget.usser != user.teacher
                                //       ? false
                                //       : true;
                                //   group_level = false;
                                //   _isloadingteachers =
                                //       widget.usser != user.teacher
                                //           ? true
                                //           : false;
                                //   if (widget.usser == user.teacher) {
                                //     _isloadinggroups = true;
                                //   }
                                //   teachername = widget.usser != user.teacher
                                //       ? 'المدرس'
                                //       : widget.teacher!.name!;
                                //   group_name = 'المجموعه';
                                //   app_name = 'الحصه';
                                // });
                                // Provider.of<AppStateManager>(context,
                                //         listen: false)
                                //     .setHomeOptions(false);
                                // Navigator.pop(context);

                                // widget.usser != user.teacher
                                //     ? await Provider.of<TeacherManager>(
                                //             context,
                                //             listen: false)
                                //         .getMoreDatafiltered(year_id_selected,
                                //             subjectId_selected)
                                //         .then((value) {
                                //         setState(() {
                                //           _isloadingteachers = false;
                                //         });
                                //       })
                                //     : await Provider.of<GroupManager>(context,
                                //             listen: false)
                                //         .getMoreDatafiltered(
                                //             year_id_selected,
                                //             subjectId_selected,
                                //             teacher_id_selected)
                                //         .then((value) {
                                //         setState(() {
                                //           _isloadinggroups = false;
                                //         });
                                //       });
                                //                             Provider.of<SubjectManager>(context,
                                //                                     listen: false)
                                //                                 .resetlist();
                                //                             setState(() {
                                //                               year_id_selected =
                                //                                   yearname = year_list[index]['year'];
                                //                               year_level = true;
                                //                               subject_level = false;
                                //                               teacher_level = false;
                                //                               group_level = false;
                                //                               _isloadingsubjects = true;
                                //                               subjectname = 'الماده الدراسيه';
                                //                               teachername = widget.usser != user.teacher
                                //                                   ? 'المدرس'
                                //                                   : widget.teacher!.name!;
                                //                               group_name = 'المجموعه';
                                //                               app_name = 'الحصه';
                                //                             });
                                //                             Navigator.pop(context);
                                //                             Provider.of<AppStateManager>(context,
                                //                                     listen: false)
                                //                                 .setHomeOptions(false);

                                //                             // await Provider.of<SubjectManager>(context,
                                //                             //         listen: false)
                                //                             //     .getMoreDatafiltered(
                                //                             //         year_id_selected.toString())
                                //                             //     .then((value) {
                                //                             //   setState(() {
                                //                             //     _isloadingsubjects = false;
                                //                             //   });
                                //                             // });
                                // final teacher_list = db.select(
                                //     'SELECT DISTINCT teacher FROM Homedata where subject LIKE "%${my_subject_list[index]['subject']}%" ');
                                // // id_list = await database.rawQuery('SELECT id_value FROM Test');
                                // my_teacher_list = teacher_list as List;

                                // print('sqflite teacher');
                                // print(teacher_list);
                              },
                              child: Text(subject_no_dublicate[index])),
                        );
                      }),
                ))
              ]));
        });
  }

  void _modalBottomSheetMenuteacherOffline(BuildContext context) {
    _loadData();
    teacher_no_dublicate = [];
    for (var i = 0; i < home_data.length; i++) {
      
      if (!teacher_no_dublicate.contains(home_data[i].teacher) &&
          home_data[i].subject == '${subjectname}') {
        teacher_no_dublicate.add(home_data[i].teacher!);
        print('sqflite subject');
        print(home_no_dublicate);
      }
    }
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              height: 250.0,
              color: Colors.transparent,
              child: Column(children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbackgroundColor1,
                  ),
                  child: Center(
                    child: Text(
                      'المدرس',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GE-bold',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: ListView.separated(
                      separatorBuilder: (BuildContext ctxt, int index) =>
                          Divider(
                            color: Colors.grey,
                            height: 2,
                          ),
                      itemCount: teacher_no_dublicate.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                              onTap: () async {
                                // Provider.of<TeacherManager>(context,
                                //         listen: false)
                                //     .resetlist();
                                // setState(() {
                                //   // subjectId_selected = subjectmanager
                                //   //     .subjects![index].id
                                //   //     .toString();
                                //   subjectname = subject_list[index]['subject'];
                                //   subject_level = true;
                                //   teacher_level = widget.usser != user.teacher
                                //       ? false
                                //       : true;

                                //   _isloadingteachers =
                                //       widget.usser != user.teacher
                                //           ? true
                                //           : false;
                                //   if (widget.usser == user.teacher) {
                                //     _isloadinggroups = true;
                                //   }
                                //   teachername = widget.usser != user.teacher
                                //       ? 'المدرس'
                                //       : widget.teacher!.name!;
                                //   group_name = 'المجموعه';
                                //   app_name = 'الحصه';
                                // });
                                // Provider.of<AppStateManager>(context,
                                //         listen: false)
                                //     .setHomeOptions(false);
                                // Navigator.pop(context);

                                // // widget.usser != user.teacher
                                // //     ? await Provider.of<TeacherManager>(
                                // //             context,
                                // //             listen: false)
                                // //         .getMoreDatafiltered(year_id_selected,
                                // //             subjectId_selected)
                                // //         .then((value) {
                                // //         setState(() {
                                // //           _isloadingteachers = false;
                                // //         });
                                // //       })
                                // //     : await Provider.of<GroupManager>(context,
                                // //             listen: false)
                                // //         .getMoreDatafiltered(
                                // //             year_id_selected,
                                // //             subjectId_selected,
                                // //             teacher_id_selected)
                                // //         .then((value) {
                                // //         setState(() {
                                // //           _isloadinggroups = false;
                                // //         });
                                // //       });
                                // Provider.of<TeacherManager>(context,
                                //         listen: false)
                                //     .resetlist();
                                // setState(() {
                                //   // year_id_selected =
                                //    teachername =
                                //       teacher_list[index]['teacher'];
                                //   year_level = true;
                                //   subject_level = true;
                                //   teacher_level = true;
                                //   group_level = true;
                                //   _isloadingsubjects = true;
                                //   subjectname = 'الماده الدراسيه';
                                //   teachername = widget.usser != user.teacher
                                //       ? 'المدرس'
                                //       : widget.teacher!.name!;
                                //   group_name = 'المجموعه';
                                //   app_name = 'الحصه';
                                // });
                                // Navigator.pop(context);
                                // Provider.of<AppStateManager>(context,
                                //         listen: false)
                                //     .setHomeOptions(false);

                                // await Provider.of<SubjectManager>(context,
                                //         listen: false)
                                //     .getMoreDatafiltered(
                                //         year_id_selected.toString())
                                //     .then((value) {
                                //   setState(() {
                                //     _isloadingsubjects = false;
                                //   });
                                // });

                                Provider.of<GroupManager>(context,
                                        listen: false)
                                    .resetlist();
                                setState(() {
                                  //year_id_selected =
                                  teachername = teacher_no_dublicate[index];
                                  year_level = true;
                                  subject_level = true;
                                  teacher_level = true;
                                  group_level = false;
                                  _isloadingsubjects = false;
                                  _isloadingteachers = false;
                                  _isloadinggroups = true;

                                  // group_name = widget.usser != user.
                                  //     ? 'المدرس'
                                  //     : widget.teacher!.name!;
                                  group_name = 'المجموعه';
                                  app_name = 'الحصه';
                                });
                                Navigator.pop(context);
                                Provider.of<AppStateManager>(context,
                                        listen: false)
                                    .setHomeOptions(false);
                                ////

                                // Provider.of<GroupManager>(context,
                                //         listen: false)
                                //     .resetlist();
                                // setState(() {
                                //   // teacher_id_selected = teachermanager
                                //   //     .teachers[index].id
                                //   //     .toString();
                                //   teachername = teacher_list[index]['teacher'];
                                //   teacher_level = true;
                                //   group_level = false;
                                //   _isloadinggroups = true;

                                //   group_name = 'المجموعه';
                                //   app_name = 'الحصه';
                                // });
                                // Navigator.pop(context);
                                // Provider.of<AppStateManager>(context,
                                //         listen: false)
                                //     .setHomeOptions(false);
                                // await Provider.of<GroupManager>(context,
                                //         listen: false)
                                //     .getMoreDatafiltered(
                                //         year_id_selected,
                                //         subjectId_selected,
                                //         teacher_id_selected)
                                //     .then((value) {
                                //   // print('valueeeeeeeeeeeeeeeeee');
                                //   // //print(value);
                                //   setState(() {
                                //     _isloadinggroups = false;
                                //   });
                                // });
                                // group_list = await database!.rawQuery(
                                //     'SELECT DISTINCT groupname FROM Homedata WHERE teacher LIKE "%${teacher_list[index]['teacher']}%" ');
                                // id_list = await database.rawQuery('SELECT id_value FROM Test');

                                // print('sqflite groupPPPPPPPP');
                                // print(group_list);
                              },
                              child: Text(teacher_no_dublicate[index])),
                        );
                      }),
                ))
              ]));
        });
  }

  void _modalBottomSheetMenugroupOffline(BuildContext context) {
     _loadData();
    group_no_dublicate = [];
    for (var i = 0; i < home_data.length; i++) {
      
      if (!group_no_dublicate.contains(home_data[i].groupname) &&
          home_data[i].teacher == '${teachername}') {
        group_no_dublicate.add(home_data[i].groupname!);
        print('sqflite subject');
        print(home_no_dublicate);
      }
    }
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              height: 250.0,
              color: Colors.transparent,
              child: Column(children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbackgroundColor3,
                  ),
                  child: Center(
                    child: Text(
                      'المجموعات',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GE-bold',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: ListView.separated(
                      separatorBuilder: (BuildContext ctxt, int index) =>
                          Divider(
                            color: Colors.grey,
                            height: 2,
                          ),
                      itemCount: group_no_dublicate.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                              onTap: () async {
                                // Provider.of<TeacherManager>(context,
                                //         listen: false)
                                //     .resetlist();
                                // setState(() {
                                //   // subjectId_selected = subjectmanager
                                //   //     .subjects![index].id
                                //   //     .toString();
                                //   subjectname = subject_list[index]['subject'];
                                //   subject_level = true;
                                //   teacher_level = widget.usser != user.teacher
                                //       ? false
                                //       : true;
                                //   group_level = false;
                                //   _isloadingteachers =
                                //       widget.usser != user.teacher
                                //           ? true
                                //           : false;
                                //   if (widget.usser == user.teacher) {
                                //     _isloadinggroups = true;
                                //   }
                                //   teachername = widget.usser != user.teacher
                                //       ? 'المدرس'
                                //       : widget.teacher!.name!;
                                //   group_name = 'المجموعه';
                                //   app_name = 'الحصه';
                                // });
                                // Provider.of<AppStateManager>(context,
                                //         listen: false)
                                //     .setHomeOptions(false);
                                // Navigator.pop(context);

                                // // widget.usser != user.teacher
                                // //     ? await Provider.of<TeacherManager>(
                                // //             context,
                                // //             listen: false)
                                // //         .getMoreDatafiltered(year_id_selected,
                                // //             subjectId_selected)
                                // //         .then((value) {
                                // //         setState(() {
                                // //           _isloadingteachers = false;
                                // //         });
                                // //       })
                                // //     : await Provider.of<GroupManager>(context,
                                // //             listen: false)
                                // //         .getMoreDatafiltered(
                                // //             year_id_selected,
                                // //             subjectId_selected,
                                // //             teacher_id_selected)
                                // //         .then((value) {
                                // //         setState(() {
                                // //           _isloadinggroups = false;
                                // //         });
                                // //       });
                                // //                             Provider.of<SubjectManager>(context,
                                // //                                     listen: false)
                                // //                                 .resetlist();
                                // //                             setState(() {
                                // //                               year_id_selected =
                                // //                                   yearname = year_list[index]['year'];
                                // //                               year_level = true;
                                // //                               subject_level = false;
                                // //                               teacher_level = false;
                                // //                               group_level = false;
                                // //                               _isloadingsubjects = true;
                                // //                               subjectname = 'الماده الدراسيه';
                                // //                               teachername = widget.usser != user.teacher
                                // //                                   ? 'المدرس'
                                // //                                   : widget.teacher!.name!;
                                // //                               group_name = 'المجموعه';
                                // //                               app_name = 'الحصه';
                                // //                             });
                                // //                             Navigator.pop(context);
                                // //                             Provider.of<AppStateManager>(context,
                                // //                                     listen: false)
                                // //                                 .setHomeOptions(false);

                                // //                             // await Provider.of<SubjectManager>(context,
                                // //                             //         listen: false)
                                // //                             //     .getMoreDatafiltered(
                                // //                             //         year_id_selected.toString())
                                // //                             //     .then((value) {
                                // //                             //   setState(() {
                                // //                             //     _isloadingsubjects = false;
                                // //                             //   });
                                // //                             // });
                                // teacher_list =await database!.rawQuery(
                                //     'SELECT DISTINCT teacher FROM Homedata where year LIKE "%${year_list[index]['subject']}%" ');
                                // // id_list = await database.rawQuery('SELECT id_value FROM Test');

                                // print('sqflite degreeeeeeeeeee');
                                // print(subject_list);

                                // Provider.of<AppStateManager>(context,
                                //             listen: false)
                                //         .setgroupID(
                                //             groupmanager.groups[index].id
                                //                 .toString(),
                                //             groupmanager.groups[index]);
                                // Provider.of<AppointmentManager>(context,
                                //       listen: false)
                                //   .resetlist();

                                setState(() {
                                  group_name = group_no_dublicate[index];
                                  year_level = true;
                                  subject_level = true;
                                  teacher_level = true;
                                  group_level = true;
                                  _isloadingappointment = true;
                                  _isloadingsubjects = false;
                                  _isloadingteachers = false;
                                  _isloadinggroups = false;

                                  // group_name = widget.usser != user.
                                  //     ? 'المدرس'
                                  //     : widget.teacher!.name!;
                                  // group_name = 'المجموعه';
                                  app_name = 'الحصه';
                                });
                                Navigator.pop(context);
                                Provider.of<AppStateManager>(context,
                                        listen: false)
                                    .setHomeOptions(false);
                                // appointment_list = await database!.rawQuery(
                                //     'SELECT  classname FROM Homedata WHERE groupname LIKE "%${group_list[index]['groupname']}%" ');
                                // // id_list = await database.rawQuery('SELECT id_value FROM Test');

                                // print('sqflite appointment');
                                // print(appointment_list);
                                // await Provider.of<AppointmentManager>(
                                //         context,
                                //         listen: false)
                                //     .get_appointments(group_id_selected)
                                //     .then((value) => setState(() {
                                //           _isloadingappointment = false;
                                //         }));
                              },
                              child: Text(group_no_dublicate[index])),
                        );
                      }),
                ))
              ]));
        });
  }

  void _modalBottomSheetMenuappointOffline(BuildContext context) {
      _loadData();
    class_no_dublicate = [];
    for (var i = 0; i < home_data.length; i++) {
      
      if (!class_no_dublicate.contains(home_data[i].classname) &&
          home_data[i].groupname == '${group_name}') {
        class_no_dublicate.add(home_data[i].classname!);
        print('sqflite subject');
        print(home_no_dublicate);
      }
    }
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              height: 250.0,
              color: Colors.transparent,
              child: Column(children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbuttonColor3,
                  ),
                  child: Center(
                    child: Text(
                      'اختار حصة',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GE-bold',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: ListView.separated(
                      separatorBuilder: (BuildContext ctxt, int index) =>
                          Divider(
                            color: Colors.grey,
                            height: 2,
                          ),
                      itemCount: group_no_dublicate.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                              onTap: () async {
                                // Provider.of<TeacherManager>(context,
                                //         listen: false)
                                //     .resetlist();
                                // setState(() {
                                //   // subjectId_selected = subjectmanager
                                //   //     .subjects![index].id
                                //   //     .toString();
                                //   subjectname = subject_list[index]['subject'];
                                //   subject_level = true;
                                //   teacher_level = widget.usser != user.teacher
                                //       ? false
                                //       : true;
                                //   group_level = false;
                                //   _isloadingteachers =
                                //       widget.usser != user.teacher
                                //           ? true
                                //           : false;
                                //   if (widget.usser == user.teacher) {
                                //     _isloadinggroups = true;
                                //   }
                                //   teachername = widget.usser != user.teacher
                                //       ? 'المدرس'
                                //       : widget.teacher!.name!;
                                //   group_name = 'المجموعه';
                                //   app_name = 'الحصه';
                                // });
                                // Provider.of<AppStateManager>(context,
                                //         listen: false)
                                //     .setHomeOptions(false);
                                // Navigator.pop(context);

                                // // widget.usser != user.teacher
                                // //     ? await Provider.of<TeacherManager>(
                                // //             context,
                                // //             listen: false)
                                // //         .getMoreDatafiltered(year_id_selected,
                                // //             subjectId_selected)
                                // //         .then((value) {
                                // //         setState(() {
                                // //           _isloadingteachers = false;
                                // //         });
                                // //       })
                                // //     : await Provider.of<GroupManager>(context,
                                // //             listen: false)
                                // //         .getMoreDatafiltered(
                                // //             year_id_selected,
                                // //             subjectId_selected,
                                // //             teacher_id_selected)
                                // //         .then((value) {
                                // //         setState(() {
                                // //           _isloadinggroups = false;
                                // //         });
                                // //       });
                                // //                             Provider.of<SubjectManager>(context,
                                // //                                     listen: false)
                                // //                                 .resetlist();
                                // //                             setState(() {
                                // //                               year_id_selected =
                                // //                                   yearname = year_list[index]['year'];
                                // //                               year_level = true;
                                // //                               subject_level = false;
                                // //                               teacher_level = false;
                                // //                               group_level = false;
                                // //                               _isloadingsubjects = true;
                                // //                               subjectname = 'الماده الدراسيه';
                                // //                               teachername = widget.usser != user.teacher
                                // //                                   ? 'المدرس'
                                // //                                   : widget.teacher!.name!;
                                // //                               group_name = 'المجموعه';
                                // //                               app_name = 'الحصه';
                                // //                             });
                                // //                             Navigator.pop(context);
                                // //                             Provider.of<AppStateManager>(context,
                                // //                                     listen: false)
                                // //                                 .setHomeOptions(false);

                                // //                             // await Provider.of<SubjectManager>(context,
                                // //                             //         listen: false)
                                // //                             //     .getMoreDatafiltered(
                                // //                             //         year_id_selected.toString())
                                // //                             //     .then((value) {
                                // //                             //   setState(() {
                                // //                             //     _isloadingsubjects = false;
                                // //                             //   });
                                // //                             // });
                                // teacher_list =await database!.rawQuery(
                                //     'SELECT DISTINCT teacher FROM Homedata where year LIKE "%${year_list[index]['subject']}%" ');
                                // // id_list = await database.rawQuery('SELECT id_value FROM Test');

                                // print('sqflite degreeeeeeeeeee');
                                // print(subject_list);

                                // Provider.of<AppStateManager>(context,
                                //             listen: false)
                                //         .setgroupID(
                                //             groupmanager.groups[index].id
                                //                 .toString(),
                                //             groupmanager.groups[index]);
                                // Provider.of<AppointmentManager>(context,
                                //       listen: false)
                                //   .resetlist();
                                ///////
                                //  setState(() {
                                //               // app_id_selected =
                                //               //     appointmentmanager
                                //               //         .appointments![index].id
                                //               //         .toString();
                                //               app_name = appointmentmanager
                                //                   .appointments![index].name
                                //                   .toString();
                                //             });
                                setState(() {
                                  app_name =
                                      class_no_dublicate[index];
                                  year_level = true;
                                  subject_level = true;
                                  teacher_level = true;
                                  group_level = true;
                                  _isloadingappointment = false;
                                  _isloadingsubjects = false;
                                  _isloadingteachers = false;
                                  _isloadinggroups = false;

                                  // // group_name = widget.usser != user.
                                  // //     ? 'المدرس'
                                  // //     : widget.teacher!.name!;
                                  // // group_name = 'المجموعه';
                                  // app_name = 'الحصه';
                                });
                                Navigator.pop(context);
                                Provider.of<AppStateManager>(context,
                                        listen: false)
                                    .setHomeOptions(false);
                                // appointment_list = await database!.rawQuery(
                                //     'SELECT DISTINCT classname FROM Homedata WHERE groupname LIKE "%${group_list[index]['groupname']}%" ');
                                // // id_list = await database.rawQuery('SELECT id_value FROM Test');

                                // print('sqflite appointment');
                                // print(appointment_list);
                                // await Provider.of<AppointmentManager>(
                                //         context,
                                //         listen: false)
                                //     .get_appointments(group_id_selected)
                                //     .then((value) => setState(() {
                                //           _isloadingappointment = false;
                                //         }));
                              },
                              child:
                                  Text(class_no_dublicate[index])),
                        );
                      }),
                ))
              ]));
        });
  }

  void _modalBottomSheetMenuyear(BuildContext context) {
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 250.0,
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbuttonColor3,
                  ),
                  child: Center(
                    child: Text(
                      'السنه الدراسيه',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GE-bold',
                      ),
                    ),
                  ),
                ),
// (!check_connectivity(this.context)) ?
//  Expanded(
//               child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20.0),
//                     topRight: Radius.circular(20.0))),
//             child: ListView.separated(
//                 separatorBuilder: (BuildContext ctxt, int index) => Divider(
//                       color: Colors.black,
//                       height: 2,
//                     ),
//                 itemCount: year_list.length,
//                 itemBuilder: (BuildContext ctxt, int index) {
//                   return Text(year_list[index]['year'] + '8iiii');
//                 }),
//           )):

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Consumer<YearManager>(
                      builder: (_, yearmanager, child) {
                        //if offline

                        if (yearmanager.years.isEmpty) {
                          if (yearmanager.loading) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ));
                          } else if (yearmanager.error) {
                            return Center(
                                child: InkWell(
                              onTap: () {
                                yearmanager.setloading(true);
                                yearmanager.seterror(false);
                                Provider.of<YearManager>(context, listen: false)
                                    .getMoreData();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text("error please tap to try again"),
                              ),
                            ));
                          }
                        } else {
                          //    var connectivityResult = await (Connectivity().checkConnectivity());
                          //  if (connectivityResult == ConnectivityResult.wifi) {}
                          return ListView.builder(
                            controller: _sc1,
                            itemCount: yearmanager.years.length +
                                (yearmanager.hasmore ? 1 : 0),
                            itemBuilder: (BuildContext ctxt, int index) {
                              if (index == yearmanager.years.length) {
                                if (yearmanager.error) {
                                  return Center(
                                      child: InkWell(
                                    onTap: () {
                                      yearmanager.setloading(true);
                                      yearmanager.seterror(false);
                                      Provider.of<YearManager>(context,
                                              listen: false)
                                          .getMoreData();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child:
                                          Text("error please tap to try again"),
                                    ),
                                  ));
                                } else {
                                  return Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: CircularProgressIndicator(),
                                  ));
                                }
                              }

                              return GestureDetector(
                                onTap: () async {
                                  Provider.of<SubjectManager>(context,
                                          listen: false)
                                      .resetlist();
                                  setState(() {
                                    year_id_selected =
                                        yearmanager.years[index].id.toString();
                                    yearname = yearmanager.years[index].name!;
                                    year_level = true;
                                    subject_level = false;
                                    teacher_level = false;
                                    group_level = false;
                                    _isloadingsubjects = true;
                                    subjectname = 'الماده الدراسيه';
                                    teachername = widget.usser != user.teacher
                                        ? 'المدرس'
                                        : widget.teacher!.name!;
                                    group_name = 'المجموعه';
                                    app_name = 'الحصه';
                                  });
                                  Navigator.pop(context);
                                  Provider.of<AppStateManager>(context,
                                          listen: false)
                                      .setHomeOptions(false);

                                  await Provider.of<SubjectManager>(context,
                                          listen: false)
                                      .getMoreDatafiltered(
                                          year_id_selected.toString())
                                      .then((value) {
                                    setState(() {
                                      _isloadingsubjects = false;
                                    });
                                  });
                                },
                                child: ListTile(
                                  title: Text(yearmanager.years[index].name!),
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _modalBottomSheetMenuteacher(BuildContext context) {
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 250.0,
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbackgroundColor1,
                  ),
                  child: Center(
                    child: Text(
                      'المدرس',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'GE-bold',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Consumer<TeacherManager>(
                      builder: (_, teachermanager, child) {
                        if (teachermanager.teachers.isEmpty) {
                          if (teachermanager.loading) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ));
                          } else if (teachermanager.error) {
                            return Center(
                                child: InkWell(
                              onTap: () {
                                teachermanager.setloading(true);
                                teachermanager.seterror(false);
                                Provider.of<TeacherManager>(context,
                                        listen: false)
                                    .getMoreDatafiltered(
                                        year_id_selected, subjectId_selected);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text("error please tap to try again"),
                              ),
                            ));
                          }
                        } else {
                          return ListView.builder(
                            controller: _sc3,
                            itemCount: teachermanager.teachers.length +
                                (teachermanager.hasmore ? 1 : 0),
                            itemBuilder: (BuildContext ctxt, int index) {
                              if (index == teachermanager.teachers.length) {
                                if (teachermanager.error) {
                                  return Center(
                                      child: InkWell(
                                    onTap: () {
                                      teachermanager.setloading(true);
                                      teachermanager.seterror(false);
                                      Provider.of<TeacherManager>(context,
                                              listen: false)
                                          .getMoreDatafiltered(year_id_selected,
                                              subjectId_selected);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child:
                                          Text("error please tap to try again"),
                                    ),
                                  ));
                                } else {
                                  return Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: CircularProgressIndicator(),
                                  ));
                                }
                              }

                              return GestureDetector(
                                onTap: () async {
                                  Provider.of<GroupManager>(context,
                                          listen: false)
                                      .resetlist();
                                  setState(() {
                                    teacher_id_selected = teachermanager
                                        .teachers[index].id
                                        .toString();
                                    teachername =
                                        teachermanager.teachers[index].name!;
                                    teacher_level = true;
                                    group_level = false;
                                    _isloadinggroups = true;

                                    group_name = 'المجموعه';
                                    app_name = 'الحصه';
                                  });
                                  Navigator.pop(context);
                                  Provider.of<AppStateManager>(context,
                                          listen: false)
                                      .setHomeOptions(false);
                                  await Provider.of<GroupManager>(context,
                                          listen: false)
                                      .getMoreDatafiltered(
                                          year_id_selected,
                                          subjectId_selected,
                                          teacher_id_selected)
                                      .then((value) {
                                    // print('valueeeeeeeeeeeeeeeeee');
                                    // //print(value);
                                    setState(() {
                                      _isloadinggroups = false;
                                    });
                                  });
                                },
                                child: ListTile(
                                  title: Text(
                                      teachermanager.teachers[index].name!),
                                ),
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _modalBottomSheetMenugroup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 250.0,
          color: Colors.transparent,
          child: Column(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kbackgroundColor3,
                ),
                child: Center(
                  child: Text(
                    'المجموعات',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'GE-bold',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Consumer<GroupManager>(
                    builder: (_, groupmanager, child) {
                      if (groupmanager.groups.isEmpty) {
                        if (groupmanager.loading) {
                          print(groupmanager.loading);
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: CircularProgressIndicator(),
                          ));
                        } else if (groupmanager.error) {
                          return Center(
                              child: InkWell(
                            onTap: () {
                              groupmanager.setloading(true);
                              groupmanager.seterror(false);
                              Provider.of<GroupManager>(context, listen: false)
                                  .getMoreDatafiltered(year_id_selected,
                                      subjectId_selected, teacher_id_selected);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text("error please tap to try again"),
                            ),
                          ));
                        }
                      } else {
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: _sc4,
                                itemCount: groupmanager.groups.length +
                                    (groupmanager.hasmore ? 1 : 0),
                                itemBuilder: (BuildContext ctxt, int index) {
                                  if (index == groupmanager.groups.length) {
                                    if (groupmanager.error) {
                                      print('2');

                                      return Center(
                                          child: InkWell(
                                        onTap: () {
                                          groupmanager.setloading(true);
                                          groupmanager.seterror(false);
                                          Provider.of<GroupManager>(context,
                                                  listen: false)
                                              .getMoreDatafiltered(
                                                  year_id_selected,
                                                  subjectId_selected,
                                                  teacher_id_selected);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                              "error please tap to try again"),
                                        ),
                                      ));
                                    } else {
                                      print('1');
                                      return Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: CircularProgressIndicator(),
                                      ));
                                    }
                                  }

                                  return GestureDetector(
                                    onTap: () async {
                                      Provider.of<AppStateManager>(context,
                                              listen: false)
                                          .setgroupID(
                                              groupmanager.groups[index].id
                                                  .toString(),
                                              groupmanager.groups[index]);
                                      setState(() {
                                        group_id_selected = groupmanager
                                            .groups[index].id
                                            .toString();
                                        group_id =
                                            groupmanager.groups[index].id!;
                                        group_name =
                                            groupmanager.groups[index].name!;
                                        print('group_nammmmmme');
                                        print(groupmanager.groups[index].name!);
                                        group_level = true;
                                        _isloadingappointment = true;
                                        app_name = 'الحصه';
                                      });
                                      Provider.of<AppStateManager>(context,
                                              listen: false)
                                          .setHomeOptions(true);
                                      Navigator.pop(context);
                                      await Provider.of<AppointmentManager>(
                                              context,
                                              listen: false)
                                          .get_appointments(group_id_selected)
                                          .then((value) => setState(() {
                                                _isloadingappointment = false;
                                              }));
                                    },
                                    child: ListTile(
                                      title: Text(
                                          groupmanager.groups[index].name!),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _modalBottomSheetMenuappoint(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 300.0,
          color: Colors.transparent,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kbackgroundColor1,
                ),
                child: Center(
                  child: Text(
                    'اختار حصه',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'GE-bold',
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 40,
              //   width: double.infinity,
              //   color: Colors.white,
              //   // decoration: BoxDecoration(
              //   //   color: kbackgroundColor2,
              //   // ),
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     child: ElevatedButton.icon(
              //       style: ElevatedButton.styleFrom(primary: kbuttonColor3),
              //       onPressed: () async {
              //         Navigator.pop(context);

              //         setState(() {
              //           _isloadingappointment = true;
              //           group_level = false;
              //         });
              //         try {
              //           await Provider.of<AppointmentManager>(context,
              //                   listen: false)
              //               .add_appointment(
              //                 group_id_selected,
              //                 formatTimeOfDay(TimeOfDay.now())[0],
              //                 formatTimeOfDay(TimeOfDay.now())[1],
              //               )
              //               .then((value) => Provider.of<AppointmentManager>(
              //                       context,
              //                       listen: false)
              //                   .get_appointments(group_id_selected))
              //               .then((value) => setState(() {
              //                     _isloadingappointment = false;
              //                     group_level = true;
              //                   }))
              //               .then((value) => setState(() {
              //                     app_id_selected =
              //                         Provider.of<AppointmentManager>(context,
              //                                 listen: false)
              //                             .currentapp!
              //                             .id
              //                             .toString();
              //                     app_name = Provider.of<AppointmentManager>(
              //                             context,
              //                             listen: false)
              //                         .currentapp!
              //                         .name!;
              //                   }))
              //               .then(
              //                 (_) => ScaffoldMessenger.of(context).showSnackBar(
              //                   SnackBar(
              //                     backgroundColor: Colors.black38,
              //                     content: Text(
              //                       'تم اضافه الحصه بنجاح',
              //                       style: TextStyle(fontFamily: 'GE-medium'),
              //                     ),
              //                     duration: Duration(seconds: 3),
              //                   ),
              //                 ),
              //               );
              //         } catch (e) {
              //           _showErrorDialog('حاول مره اخري ', 'حدث خطأ');
              //         }
              //       },
              //       icon: Icon(Icons.add),
              //       label: Text(
              //         'أضف حصه جديده',
              //         style: TextStyle(
              //             fontFamily: 'GE-medium', color: Colors.black),
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(20.0),
                    //     topRight: Radius.circular(20.0))
                  ),
                  child: Consumer<AppointmentManager>(
                    builder: (_, appointmentmanager, child) {
                      if (appointmentmanager.appointments!.isEmpty) {
                        if (!appointmentmanager.loading) {
                          // print('1');
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'لا توجد حصص',
                                style: TextStyle(
                                    fontFamily: 'GE-medium',
                                    color: Colors.black),
                              ),
                            ),
                          );
                        } else if (appointmentmanager.error) {
                          // print('2');

                          return Center(
                              child: InkWell(
                            onTap: () {
                              appointmentmanager.setloading(true);
                              appointmentmanager.seterror(false);
                              Provider.of<AppointmentManager>(context,
                                      listen: false)
                                  .get_appointments(group_id_selected);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text("error please tap to try again"),
                            ),
                          ));
                        }
                      } else {
                        // print('3');

                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount:
                                    appointmentmanager.appointments!.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  if (index ==
                                      appointmentmanager.appointments!.length) {
                                    if (appointmentmanager.error) {
                                      return Center(
                                          child: InkWell(
                                        onTap: () {
                                          appointmentmanager.setloading(true);
                                          appointmentmanager.seterror(false);
                                          Provider.of<AppointmentManager>(
                                                  context,
                                                  listen: false)
                                              .get_appointments(
                                                  group_id_selected);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                              "error please tap to try again"),
                                        ),
                                      ));
                                    } else {
                                      return Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: CircularProgressIndicator(),
                                      ));
                                    }
                                  }

                                  return Column(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              app_id_selected =
                                                  appointmentmanager
                                                      .appointments![index].id
                                                      .toString();
                                              app_name = appointmentmanager
                                                  .appointments![index].name
                                                  .toString();
                                            });
                                            Navigator.pop(context);
                                            // Provider.of<AppStateManager>(context,
                                            //         listen: false)
                                            //     .setgroupID(
                                            //         appointmentmanager
                                            //             .groups[index].id
                                            //             .toString(),
                                            //         appointmentmanager.groups[index]);
                                            // setState(() {
                                            //   group_id_selected = appointmentmanager
                                            //       .groups[index].id
                                            //       .toString();
                                            //   group_name = appointmentmanager
                                            //       .groups[index].name!;
                                            //   group_level = true;
                                            // });
                                            // Provider.of<AppStateManager>(context,
                                            //         listen: false)
                                            //     .setHomeOptions(true);
                                            // Navigator.pop(context);
                                          },
                                          //  ' الساعه :   ${appointmentmanager.appointments![index].time!
                                          // .toString()}'
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: double.infinity,
                                            height: 30,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                appointmentmanager
                                                    .appointments![index].name!,
                                                style: TextStyle(
                                                    fontFamily: 'GE-light'),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                              ),
                                            ),
                                          )

                                          //  ListTile(
                                          //   title: Text(
                                          //     ' الساعه :   ${appointmentmanager.appointments![index].time!.toString()}',
                                          //     style:
                                          //         TextStyle(fontFamily: 'GE-light'),
                                          //   ),
                                          //   trailing: Text(
                                          //     ' التاريخ :   ${appointmentmanager.appointments![index].date!.toString()}',
                                          //     style:
                                          //         TextStyle(fontFamily: 'GE-light'),
                                          //   ),
                                          // ),
                                          ),
                                      Divider(),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorDialog(String message, String title) {
    showDialog(
      context: this.context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontFamily: 'GE-Bold'),
        ),
        content: Text(
          message,
          style: TextStyle(fontFamily: 'AraHamah1964R-Bold'),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kbuttonColor2)),
              // color: kbackgroundColor1,
              child: Text(
                'حسنا',
                style: TextStyle(fontFamily: 'GE-medium', color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  List<String> years_levels = [];
  List<String> subjects = [];
  List<String> teachers = [];
  List<String> groups = [];
  var year_level = false;
  var subject_level = false;
  var teacher_level = false;
  var group_level = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * .7,
      child: Column(
        children: [
          // GestureDetector(
          //     onTap: () {
          //       // if (check_connectivity() == false) {
          //       //   setState(() {
          //       //     no_internet = true;
          //       //     print('no   ooooooooooooooo');
          //       //   });
          //       //   if (Provider.of<DataConnectionStatus>(context) ==
          //       //       DataConnectionStatus.disconnected) {
          //       //     print('no interrrnet');
          //       //   } else {
          //       //     print('yes interrrnet');
          //       //   }
          //       // }
          //     },
          //     child: Text('hhhhhhhhhhhhh')),
          // !check_connectivity(this.context)
          //     ? Expanded(
          //         child: Container(
          //         decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(20.0),
          //                 topRight: Radius.circular(20.0))),
          //         child: ListView.separated(
          //             separatorBuilder: (BuildContext ctxt, int index) =>
          //                 Divider(
          //                   color: Colors.black,
          //                   height: 2,
          //                 ),
          //             itemCount: year_list.length,
          //             itemBuilder: (BuildContext ctxt, int index) {
          //               return Text(year_list[index]['year'] + '8iiii');
          //             }),
          //       ))
          //     : SizedBox(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Choice_container(
                  hinttext: yearname,
                  color: kbuttonColor3,
                  items: years_levels,
                  size: widget.size,
                  fnc: check_connectivity(context) == true
                      ? () => _modalBottomSheetMenuyear(context)
                      : () => _modalBottomSheetMenuyearOffline(context),
                  loading: _isloadingyears,
                  active: true,
                ),
                Choice_container(
                  hinttext: subjectname,
                  color: kbackgroundColor1,
                  items: subjects,
                  size: widget.size,
                  fnc: check_connectivity(context) == true
                      ? () => _modalBottomSheetMenusubject(context)
                      : () => _modalBottomSheetMenuSubjectOffline(context),
                  active: year_level == true,
                  loading: _isloadingsubjects,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Choice_container(
                  hinttext: teachername,
                  color: kbackgroundColor1,
                  items: teachers,
                  size: widget.size,
                  fnc: check_connectivity(context) == true
                      ? () => _modalBottomSheetMenuteacher(context)
                      : () => _modalBottomSheetMenuteacherOffline(context),
                  // (){
                  //   if(widget.usser != user.teacher){
                  //          return _modalBottomSheetMenuteacher(context);
                  //   }
                  //   if(check_connectivity(context) == true){
                  //           return _modalBottomSheetMenuteacher(context);
                  //   }

                  //   else{
                  //      return _modalBottomSheetMenuteacherOffline(context);

                  //   }
                  // } ,

                  active: subject_level == true,
                  loading: _isloadingteachers,
                ),
                Choice_container(
                  hinttext: group_name,
                  color: kbackgroundColor3,
                  items: groups,
                  size: widget.size,
                  fnc: check_connectivity(context) == true
                      ? () => _modalBottomSheetMenugroup(context)
                      : () => _modalBottomSheetMenugroupOffline(context),
                  active: teacher_level == true,
                  loading: _isloadinggroups,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button_Container(
                  color: kbuttonColor2,
                  size: widget.size,
                  text: 'ادخال طالب',
                  fnc: () async {
                    Provider.of<AppStateManager>(context, listen: false)
                        .registerStudent(true);
                  },
                ),
                (widget.usser == user.assistant || widget.usser == user.teacher)
                    ? Button_Container(
                        color: kbuttonColor2,
                        size: widget.size,
                        text: 'المواد الدراسيه',
                        fnc: () async {
                          Provider.of<AppStateManager>(context, listen: false)
                              .modifySubjects(true);
                        },
                      )
                    : Button_Container(
                        color: kbuttonColor3,
                        size: widget.size,
                        text: 'ادخال معلم',
                        fnc: () async {
                          Provider.of<AppStateManager>(context, listen: false)
                              .registerTeacher(true);
                        },
                      ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button_Container(
                  color: kbackgroundColor1,
                  size: widget.size,
                  text: 'السنوات الدراسيه',
                  fnc: () async {
                    Provider.of<AppStateManager>(context, listen: false)
                        .addYears(true);
                  },
                ),
                Button_Container(
                  color: kbackgroundColor3,
                  size: widget.size,
                  text: 'ادخال مجموعه',
                  fnc: () async {
                    Provider.of<AppStateManager>(context, listen: false)
                        .registerGroup(true);
                  },
                ),
              ],
            ),
          ),
          (widget.usser == user.assistant || widget.usser == user.teacher)
              ? Container()
              : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button_Container(
                        color: kbuttonColor2,
                        size: widget.size,
                        text: 'المواد الدراسيه',
                        fnc: () async {
                          Provider.of<AppStateManager>(context, listen: false)
                              .modifySubjects(true);
                        },
                      ),
                      Container(
                        width: widget.size.width * .45,
                      )
                    ],
                  ),
                ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  // width: double.infinity,
                  color: Colors.white,
                  // decoration: BoxDecoration(
                  //   color: kbackgroundColor2,
                  // ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: group_level
                            ? kbuttonColor3
                            : kbuttonColor3.withOpacity(.5),
                      ),
                      onPressed: group_level
                          ? () async {
                              final TimeOfDay? newTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (newTime != null) {
                                print('object');
                                setState(() {
                                  _isloadingappointment = true;
                                  group_level = false;
                                });
                                try {
                                  await Provider.of<AppointmentManager>(context,
                                          listen: false)
                                      .add_appointment(
                                        group_id_selected,
                                        formatTimeOfDay(newTime)[0],
                                        formatTimeOfDay(TimeOfDay.now())[1],
                                      )
                                      .then((value) => Provider.of<
                                                  AppointmentManager>(context,
                                              listen: false)
                                          .get_appointments(group_id_selected))
                                      .then((value) => setState(() {
                                            _isloadingappointment = false;
                                            group_level = true;
                                          }))
                                      .then((value) => setState(() {
                                            app_id_selected =
                                                Provider.of<AppointmentManager>(
                                                        context,
                                                        listen: false)
                                                    .currentapp!
                                                    .id
                                                    .toString();
                                            app_name =
                                                Provider.of<AppointmentManager>(
                                                        context,
                                                        listen: false)
                                                    .currentapp!
                                                    .name!;
                                          }))
                                      .then(
                                        (_) => ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.black38,
                                            content: Text(
                                              'تم اضافه الحصه بنجاح',
                                              style: TextStyle(
                                                  fontFamily: 'GE-medium'),
                                            ),
                                            duration: Duration(seconds: 3),
                                          ),
                                        ),
                                      );
                                } catch (e) {
                                  _showErrorDialog('حاول مره اخري ', 'حدث خطأ');
                                }
                              }
                            }
                          : () {},
                      icon: Icon(Icons.add),
                      label: Container(
                          // '',
                          // style: TextStyle(
                          //     fontFamily: 'GE-medium', color: Colors.black),
                          ),
                    ),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.only(right: 6),
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  height: 30,
                  width: widget.size.width * .6,
                  decoration: BoxDecoration(
                    color: group_level
                        ? kbuttonColor3
                        : kbuttonColor3.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: check_connectivity(context) == true
                        //||group_level
                        ? () => _modalBottomSheetMenuappoint(context)
                        : () => _modalBottomSheetMenuappointOffline(context),
                    //  group_level
                    //     ? () {
                    //        _modalBottomSheetMenuappoint(context);
                    //       }
                    //     : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          _isloadingappointment
                              ? CircularProgressIndicator()
                              : Container(
                                  width: widget.size.width * .5,
                                  child: Text(
                                    app_name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontFamily: 'AraHamah1964B-Bold',
                                        fontSize: 20,
                                        color: group_level
                                            ? Colors.black
                                            : Colors.black26),
                                  ),
                                ),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!Platform.isWindows)
            Consumer<AppStateManager>(
              builder: (context, appstatemanager, child) => GestureDetector(
                onTap: app_name != 'الحصه' && _loadingscann == false
                    ? () async {
                        setState(() {
                          _loadingscann = true;
                        });
                        // String res = await FlutterBarcodeScanner.scanBarcode(
                        //     '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                        try {
                          String res = await FlutterBarcodeScanner.scanBarcode(
                              '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                          print(app_id_selected);
                          print(res);
                          dynamic resp = await Provider.of<AppointmentManager>(
                                  context,
                                  listen: false)
                              .attendlesson(res, app_id_selected!);

                          if (resp['last_appointment_attend'] == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orange[200],
                                content: Text(
                                  ' تم التسجيل بنجاح والحصه السابقه لم يحضرها',
                                  style: TextStyle(fontFamily: 'GE-medium'),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                          if (resp['last_appointment_attend'] == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green[300],
                                content: Text(
                                  ' تم التسجيل بنجاح',
                                  style: TextStyle(fontFamily: 'GE-medium'),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                          // if (resp['last_appointment_attend'] ==
                          //     'This Group Has not have appointments') {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       backgroundColor: Colors.green[300],
                          //       content: Text(
                          //         ' تم التسجيل بنجاح',
                          //         style: TextStyle(fontFamily: 'GE-medium'),
                          //       ),
                          //       duration: Duration(seconds: 3),
                          //     ),
                          //   );
                          // }
                        } on HttpException catch (e) {
                          _showErrorDialog(e.toString(), 'حدث خطأ');
                        } catch (e) {
                          _showErrorDialog('حاول مره اخري', 'حدث خطأ');
                        }
                        setState(() {
                          _loadingscann = false;
                        });

                        // .then((value) =>
                        //     _showErrorDialog(app_id_selected, res));
                      }
                    // .then((value) =>
                    //     _showErrorDialog(app_id_selected, scanResult_code))
                    : null,
                child: Scan_button(
                  active: app_name != 'الحصه' && _loadingscann == false,
                ),
              ),
            ),
          if (Platform.isWindows)
            Consumer<AppStateManager>(
                builder: (context, appstatemanager, child) {
              String inputK = "";
              FocusNode focusNode = FocusNode();
              return RawKeyboardListener(
                autofocus: true,
                focusNode: focusNode,
                onKey: (RawKeyEvent event) async {
                  if (event.runtimeType.toString() == 'RawKeyDownEvent' &&
                      (app_name != 'الحصه' && _loadingscann == false)) {
                    //   if (event.isKeyPressed(LogicalKeyboardKey.space)) {
                    String key = event.logicalKey.keyLabel;
                    // print(key);
                    // print('object');
                    if (key != null) {
                      setState(() {
                        inputK += key;
                      });
                    }

                    setState(() {
                      _loadingscann = true;
                    });
                    if (app_id_selected == null) {
                      _showErrorDialog('اختر حصه', 'حدث خطأ');
                      return;
                    }

                    try {
                      String res = inputK;
                      dynamic resp = await Provider.of<AppointmentManager>(
                              context,
                              listen: false)
                          .attendlesson(res, app_id_selected!);
                      //if ofline

                      if (resp['last_appointment_attend'] == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.orange[200],
                            content: Text(
                              ' تم التسجيل بنجاح والحصه السابقه لم يحضرها',
                              style: TextStyle(fontFamily: 'GE-medium'),
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                      if (resp['last_appointment_attend'] == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green[300],
                            content: Text(
                              ' تم التسجيل بنجاح',
                              style: TextStyle(fontFamily: 'GE-medium'),
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    } on HttpException catch (e) {
                      setState(() {
                        _loadingscann = false;
                      });
                      // _showErrorDialog(e.toString(), 'حدث خطأ');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red[300],
                          content: Text(
                            e.toString(),
                            style: TextStyle(fontFamily: 'GE-medium'),
                          ),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } catch (e) {
                      setState(() {
                        _loadingscann = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red[300],
                          content: Text(
                            'حدث خطأ',
                            style: TextStyle(fontFamily: 'GE-medium'),
                          ),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                    setState(() {
                      _loadingscann = false;
                    });
                  }
                  ;
                }

                // },
                ,
                child: Scan_button(
                  active: app_name != 'الحصه' && _loadingscann == false,
                ),
              );
            })
        ],
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    late String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      _showErrorDialog('حاول مره اخري', 'حدث خطا');
    }

    if (!mounted) return;

    setState(() {
      scanResult_code = barcodeScanRes;
    });
  }

  Future scanBarcode() async {
    String? scanResult;
    setState(() {
      _scanloading = true;
    });
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
              '#ff6666', "cancel", true, ScanMode.BARCODE)
          .then((value) {
        print(value);
      });
      // .then(
      //   (value) => Provider.of<AppointmentManager>(context, listen: false)
      //       .attendlesson(group_id_selected, value, app_id_selected),
      // )
      // .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       backgroundColor: Colors.green[300],
      //       content: Text(
      //         'تم تسجيل حضور الطالب بنجاح',
      //         style: TextStyle(fontFamily: 'GE-medium'),
      //       ),
      //       duration: Duration(seconds: 3),
      //     )));
    } on PlatformException {
      _showErrorDialog('حاول مره اخري', 'حدث خطا');
    }
    if (!mounted) return;
    setState(() {
      scanResult_code = scanResult!;

      _scanloading = false;
    });
  }
}

class Choice_container extends StatelessWidget {
  Choice_container(
      {Key? key,
      required this.size,
      required this.color,
      required this.items,
      // required this.value,
      required this.fnc,
      required this.hinttext,
      required this.active,
      this.loading = false})
      : super(key: key);
  final String hinttext;
  final Size size;
  final Color color;
  final List<String> items;
  // final String value;
  final Function() fnc;
  final bool active;
  final bool? loading;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 6),
      margin: EdgeInsets.all(1),
      alignment: Alignment.center,
      height: size.height * .6 * .14,
      // height: 40,
      width: size.width * .45,
      decoration: BoxDecoration(
        color: active ? color : color.withOpacity(.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: active ? () => fnc() : null,
        child: Container(
          child: Row(
            children: [
              loading!
                  ? CircularProgressIndicator()
                  : Container(
                      width: size.width * .35,
                      child: Text(
                        hinttext,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontFamily: 'AraHamah1964B-Bold',
                            fontSize: 20,
                            color: active ? Colors.black : Colors.black26),
                      ),
                    ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ),
      ),
    );
  }
}

class Button_Container extends StatelessWidget {
  const Button_Container(
      {Key? key,
      required this.size,
      required this.color,
      required this.text,
      required this.fnc})
      : super(key: key);
  final Size size;
  final Color color;
  final String text;
  final VoidCallback fnc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: fnc,
      child: Container(
        margin: EdgeInsets.all(1),
        alignment: Alignment.center,
        height: size.height * .6 * .14,
        // height: 40,
        width: size.width * .45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              width: size.width * .4,
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    fontFamily: 'AraHamah1964B-Bold',
                    fontSize: size.width * .06),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Define tables that can model a database of recipes.

