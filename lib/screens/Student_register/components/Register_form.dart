import 'dart:async';

import 'package:attendance/helper/httpexception.dart';
import 'package:attendance/managers/Student_manager.dart';
import 'package:attendance/managers/cities_manager.dart';
import 'package:attendance/managers/group_manager.dart';
import 'package:attendance/managers/subject_manager.dart';
import 'package:attendance/models/StudentSearchModel.dart';
import 'package:attendance/models/city.dart';
import 'package:attendance/models/student.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
// import 'package:sqflite/sqflite.dart';

import '../../../constants.dart';

// import 'contacts_widget.dart';
String path = '';

class Register_Form extends StatefulWidget {
  const Register_Form({
    Key? key,
    required this.size,
    this.edit,
    this.student,
  }) : super(key: key);

  final Size size;
  final bool? edit;
  final StudentModelSearch? student;

  @override
  _Register_FormState createState() => _Register_FormState();
}

class _Register_FormState extends State<Register_Form> {
  // static late ConnectivityResult _connectionStatus;
  // Connectivity? connectivity;
  // StreamSubscription<ConnectivityResult>? subscription;
  final GlobalKey<FormState> _formKey = GlobalKey();
  void _submit() async {
    Context context;
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_register_data['gender'] == null ||
        // langname == 'اللغه الثانيه' ||
        cityname == 'المحافظه' ||
        _groups_shown.isEmpty) {
      return;
    }
    _formKey.currentState!.save();
    // print('asdasdasd');
    // setState(() {
    //   _isLoading = true;
    //   ConnectivityResult.wifi;
    // });
    print(_groups_id.join(','));
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.wifi) {
      try {
        await Provider.of<StudentManager>(this.context, listen: false)
            .add_student(
          nameController.text,
          emailController.text,
          phonecontroller.text,
          schoolController.text,
          notesController.text,
          cityId_selected,
          _groups_id,
          parentNameController.text,
          relationController.text,
          parentphoneController.text,
          parentWhatsController.text,
          _register_data['gender'],
          studyTypeController.text,
          langId_selected,
          discountController.text,
          barCodeController.text,
          passwordcontroller.text,
          confirmpasswordController.text,
          parentemailController.text,
          parentpasswordController.text,
        )
            .then((_) {
          nameController.text = '';
          parentNameController.text = '';
          relationController.text = '';
          parentPhoneController.text = '';
          parentWhatsController.text = '';
          schoolController.text = '';
          barCodeController.text = '';
          groupController.text = '';
          discountController.text = '';
          languageController.text = '';
          notesController.text = '';
          emailController.text = '';
          studyTypeController.text = '';
          phonecontroller.text = '';
          passwordcontroller.text = '';
          confirmpasswordController.text = '';
          parentphoneController.text = '';
          parentemailController.text = '';
          parentpasswordController.text = '';
          _register_data['gender'] = null;
          _register_data['language'] = null;
          cityname = 'المحافظه';
          langname = 'اللغه الثانيه';
          _groups_id = [];
          _groups_shown = [];
        }).then((value) => ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green[300],
                  content: Text(
                    'تم اضافه الطالب بنجاح',
                    style: TextStyle(fontFamily: 'GE-medium'),
                  ),
                  duration: Duration(seconds: 3),
                )));
      } on HttpException catch (error) {
        _showErrorDialog(error.toString(), this.context);
      } catch (error) {
        print(error);
        const errorMessage = 'حاول مره اخري';
        _showErrorDialog(errorMessage, this.context);
      }
      setState(() {
        _isLoading = false;
      });
    // } else {
    //   setState(() {
    //     connectivityResult;
    //   });
    //   print("no connection");

      // var databasesPath = await getDatabasesPath();
      // path = join(databasesPath, 'studentregister.db');

//Delete the database
      //await deleteDatabase(path);

// open the database
      // Database database = await openDatabase(path, version: 1,
      //     onCreate: (Database db, int version) async {
      //   // When creating the db, create the table
      //   await db.execute(
      //       'CREATE TABLE Student (id INTEGER PRIMARY KEY,  name TEXT,email  TEXT,phone TEXT,school TEXT,notes TEXT,cityId  TEXT,groups_id  TEXT, parentName TEXT, relation TEXT,parentphone TEXT,parentWhats TEXT,gender  TEXT,studyType TEXT, langId TEXT,discount TEXT,barCode TEXT,password TEXT,confirmpassword TEXT,parentemail TEXT,parentpassword TEXT, )');
      // });

      // await database.transaction((txn) async {
      //   int id1 = await txn.rawInsert(
      //       'INSERT INTO Student( name ,email  ,phone ,school ,notes ,cityId  ,groups_id  , parentName , relation ,parentphone ,parentWhats ,gender  ,studyType , langId ,discount ,barCode ,password ,confirmpassword ,parentemail ,parentpassword , ) VALUES( $nameController.text,$emailController.text,$phonecontroller.text,$schoolController.text,$notesController.text,$cityId_selected,$_groups_id,$parentNameController.text,$relationController.text,$parentphoneController.text,$parentWhatsController.text,${_register_data['gender']},$studyTypeController.text,$langId_selected,$discountController.text,$barCodeController.text,$passwordcontroller.text,confirmpasswordController.text,$parentemailController.text,$parentpasswordController.text,)');
      //   print('inserted1: $id1');
      //   // count_deree + 1;

      //   //
      // });
      // // Update some record
      // if (count_deree > 1) {
      //   int count = await database.rawUpdate(
      //       'UPDATE Test SET degree = ?, id_value = ? WHERE id_value = ?',
      //       ['$result', '$Student__id', '$Student__id']);
      //   print('updated: $count');
      // }

      // Get the records
      // List<Map> list = await database.rawQuery('SELECT * FROM Test');
      // degree_list = await database.rawQuery('SELECT degree FROM Test');
      // id_list = await database.rawQuery('SELECT id_value FROM Test');

      // print('sqflite degree');
      // print(degree_list[0]['degree']);
      print('sqflite list');
      // print(list);

      //for(true){}
      // print('_connectionStatus');
      // print(_connectionStatus.toString());
      // setState(() {
      //   if (_connectionStatus == ConnectivityResult.none) {
      //     print("no connection again");
      //   } else {
      //     print("reconnected");
      //   }
      // });

    //}
  }

  void _modify() async {
    Context context;
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_register_data['gender'] == null ||
        // langname == 'اللغه الثانيه' ||
        cityname == 'المحافظه' ||
        _groups_shown.isEmpty) {
      return;
    }
    _formKey.currentState!.save();
    // print('asdasdasd');
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<StudentManager>(this.context, listen: false)
          .modify_student(
              widget.student!.id.toString(),
              nameController.text,
              emailController.text,
              phonecontroller.text,
              schoolController.text,
              notesController.text,
              cityId_selected,
              _groups_id,
              parentNameController.text,
              relationController.text,
              parentphoneController.text,
              parentWhatsController.text,
              _register_data['gender'],
              studyTypeController.text,
              langId_selected,
              discountController.text.toString(),
              barCodeController.text,
              passwordcontroller.text,
              confirmpasswordController.text)
          .then(
            (value) => Provider.of<StudentManager>(this.context, listen: false)
              ..getMoreDatafilteredId(
                widget.student!.id.toString(),
              ),
          )
          .then((_) {
        Navigator.pop(this.context);
      }).then((value) => ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                backgroundColor: Colors.green[300],
                content: Text(
                  'تم تعديل الطالب بنجاح',
                  style: TextStyle(fontFamily: 'GE-medium'),
                ),
                duration: Duration(seconds: 3),
              )));
    } on HttpException catch (error) {
      _showErrorDialog(error.toString(), this.context);
    } catch (error) {
      const errorMessage = 'حاول مره اخري';
      _showErrorDialog(errorMessage, this.context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message, context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'حدث خطا',
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
                  backgroundColor:
                      MaterialStateProperty.all(kbackgroundColor1)),
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

  var _isLoading = true;
  Map<String, dynamic> _register_data = {
    // 'second_lang': '',
    'language': null,
    'observations': '',
    'gender': null,
    'track': null,
    'government': null,
  };
  String cityname = 'المحافظه';
  String langname = 'اللغه الثانيه';
  late String cityId_selected;
  dynamic langId_selected = null;
  List<String> _groups_id = [];
  List<String> _groups_shown = [];

  void _modalBottomSheetMenulang(BuildContext context) {
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
                      'اللغه الثانيه',
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
                                Provider.of<CitiesManager>(context,
                                        listen: false)
                                    .getMoreData();
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
                                      Provider.of<CitiesManager>(context,
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
                                onTap: () {
                                  setState(() {
                                    langId_selected = subjectmanager
                                        .subjects![index].id
                                        .toString();
                                    langname =
                                        subjectmanager.subjects![index].name!;
                                  });
                                  Navigator.pop(context);
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

  void _modalBottomSheetMenu(BuildContext context) {
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
                      'المحافظه',
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
                    child: Consumer<CitiesManager>(
                      builder: (_, citymanager, child) {
                        if (citymanager.cities!.isEmpty) {
                          if (citymanager.loading) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ));
                          } else if (citymanager.error) {
                            return Center(
                                child: InkWell(
                              onTap: () {
                                citymanager.setloading(true);
                                citymanager.seterror(false);
                                Provider.of<CitiesManager>(context,
                                        listen: false)
                                    .getMoreData();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text("error please tap to try again"),
                              ),
                            ));
                          }
                        } else {
                          return ListView.builder(
                            controller: _sc,
                            itemCount: citymanager.cities!.length +
                                (citymanager.hasmore ? 1 : 0),
                            itemBuilder: (BuildContext ctxt, int index) {
                              if (index == citymanager.cities!.length) {
                                if (citymanager.error) {
                                  return Center(
                                      child: InkWell(
                                    onTap: () {
                                      citymanager.setloading(true);
                                      citymanager.seterror(false);
                                      Provider.of<CitiesManager>(context,
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
                                onTap: () {
                                  setState(() {
                                    cityId_selected = citymanager
                                        .cities![index].id
                                        .toString();
                                    cityname = citymanager.cities![index].name!;
                                  });
                                  Navigator.pop(context);
                                },
                                child: ListTile(
                                  title: Text(citymanager.cities![index].name!),
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

  void _modalBottomSheetMenumulti(BuildContext context) {
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
                                  .getMoreData();
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
                                controller: _sc2,
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
                                              .getMoreData();
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

                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter checkboxstate) {
                                      return ListTile(
                                        title: Text(
                                            groupmanager.groups[index].name!),
                                        leading: Checkbox(
                                          onChanged: (value) {
                                            checkboxstate(() {
                                              groupmanager
                                                      .groups[index].choosen =
                                                  !groupmanager
                                                      .groups[index].choosen!;
                                            });
                                          },
                                          value: groupmanager
                                              .groups[index].choosen,
                                        ),
                                      );
                                    },
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
    ).then((value) {
      setState(() {
        _groups_id = Provider.of<GroupManager>(context, listen: false)
            .groups
            .where((element) => element.choosen == true)
            .toList()
            .map((e) => e.id.toString())
            .toList();
        _groups_shown = Provider.of<GroupManager>(context, listen: false)
            .groups
            .where((element) => element.choosen == true)
            .toList()
            .map((e) => e.name.toString())
            .toList();
      });
    });
  }

  var nameController = TextEditingController();
  var parentNameController = TextEditingController();
  var relationController = TextEditingController();
  var parentPhoneController = TextEditingController();
  var parentWhatsController = TextEditingController();
  var schoolController = TextEditingController();
  var barCodeController = TextEditingController();
  var groupController = TextEditingController();
  var discountController = TextEditingController();
  var languageController = TextEditingController();
  var notesController = TextEditingController();
  var emailController = TextEditingController();
  var studyTypeController = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var parentphoneController = TextEditingController();
  var parentemailController = TextEditingController();
  var parentpasswordController = TextEditingController();
  late int _selectedCity;

  List<String> _groups = [];
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  final focus7 = FocusNode();
  final focus8 = FocusNode();
  final focus9 = FocusNode();
  final focus10 = FocusNode();
  final focus11 = FocusNode();
  final focus12 = FocusNode();
  final focus13 = FocusNode();
  final focus14 = FocusNode();
  final focus15 = FocusNode();
  final focus16 = FocusNode();
  ScrollController _sc = new ScrollController();
  ScrollController _sc2 = new ScrollController();
  ScrollController _sc3 = new ScrollController();
  @override
  void dispose() {
    _isLoading = false;
    nameController.dispose();
    parentNameController.dispose();
    relationController.dispose();
    parentPhoneController.dispose();
    parentWhatsController.dispose();
    schoolController.dispose();
    barCodeController.dispose();
    groupController.dispose();
    discountController.dispose();
    languageController.dispose();
    notesController.dispose();
    emailController.dispose();
    studyTypeController.dispose();
    phonecontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordController.dispose();
    parentphoneController.dispose();
    parentemailController.dispose();
    parentpasswordController.dispose();
    focus1.dispose();
    focus2.dispose();
    focus3.dispose();
    focus4.dispose();
    focus5.dispose();
    focus6.dispose();
    focus7.dispose();
    focus8.dispose();
    focus9.dispose();
    focus10.dispose();
    focus11.dispose();
    focus12.dispose();
    focus13.dispose();
    focus14.dispose();
    _sc.dispose();
    _sc2.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // print(widget.student!.id);
    // print(widget.edit);
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
      widget.edit!
          ? nameController.text = widget.student!.name ?? ''
          : nameController.text = '';
      widget.edit!
          ? parentNameController.text = widget.student!.parent ?? ''
          : parentNameController.text = '';
      widget.edit!
          ? relationController.text = widget.student!.relationType ?? ''
          : relationController.text = '';
      widget.edit!
          ? parentPhoneController.text = widget.student!.parentPhone ?? ''
          : parentPhoneController.text = '';
      widget.edit!
          ? parentWhatsController.text = widget.student!.parentWhatsapp ?? ''
          : parentWhatsController.text = '';
      widget.edit!
          ? schoolController.text = widget.student!.school ?? ''
          : schoolController.text = '';
      widget.edit!
          ? barCodeController.text = widget.student!.code!.name ?? ''
          : barCodeController.text = '';
      widget.edit!
          ? discountController.text = widget.student!.discount ?? ''
          : discountController.text = '';
      widget.edit!
          ? notesController.text = widget.student!.note ?? ''
          : notesController.text = '';
      widget.edit!
          ? emailController.text = widget.student!.email ?? ''
          : emailController.text = '';
      widget.edit!
          ? studyTypeController.text = widget.student!.studyType ?? ''
          : studyTypeController.text = '';
      widget.edit!
          ? phonecontroller.text = widget.student!.phone!
          : phonecontroller.text = '';
      widget.edit!
          ? cityId_selected = widget.student!.city!.id!.toString()
          : cityId_selected = '';

      widget.edit!
          ? parentphoneController.text = widget.student!.parentPhone ?? ''
          : parentphoneController.text = '';
      if (widget.edit! && widget.student!.gender == 'ذكر')
        _register_data['gender'] = 'ذكر';
      if (widget.edit! && widget.student!.gender != 'ذكر')
        _register_data['gender'] = 'أنثي';
      if (widget.edit!) cityname = widget.student!.city!.name.toString();
      if (widget.edit!) cityId_selected = widget.student!.city!.id.toString();
      if (widget.edit!)
        langname = widget.student!.secLang == null
            ? 'اللغه الثانيه'
            : widget.student!.secLang!.name.toString();
      if (widget.edit!)
        langId_selected = widget.student!.secLang == null
            ? null
            : widget.student!.secLang!.id.toString();
      if (widget.edit!) {
        _groups_id =
            widget.student!.groups!.map((e) => e.id.toString()).toList();
        _groups_shown =
            widget.student!.groups!.map((e) => e.name.toString()).toList();
        // print(widget.student!.secondLanguage.toString());
      } else {
        _groups_id = [];
        _groups_shown = [];
      }

      Future.delayed(Duration.zero, () async {
        Provider.of<CitiesManager>(this.context, listen: false).resetlist();
        Provider.of<GroupManager>(this.context, listen: false).resetlist();
        Provider.of<SubjectManager>(this.context, listen: false).resetlist();
        try {
          await Provider.of<CitiesManager>(this.context, listen: false)
              .getMoreData()
              .then((value) =>
                  Provider.of<GroupManager>(this.context, listen: false)
                      .getMoreData())
              .then((value) =>
                  Provider.of<SubjectManager>(this.context, listen: false)
                      .getMoreData())
              .then((_) {
            setState(() {
              _isLoading = false;
            });
          });
        } catch (e) {}
        if (!mounted) return;

        _sc.addListener(
          () {
            if (_sc.position.pixels == _sc.position.maxScrollExtent) {
              Provider.of<CitiesManager>(this.context, listen: false)
                  .getMoreData();
            }
          },
        );
        _sc2.addListener(
          () {
            if (_sc2.position.pixels == _sc2.position.maxScrollExtent) {
              Provider.of<GroupManager>(this.context, listen: false)
                  .getMoreData();
            }
          },
        );
        _sc3.addListener(
          () {
            if (_sc3.position.pixels == _sc3.position.maxScrollExtent) {
              Provider.of<SubjectManager>(this.context, listen: false)
                  .getMoreData();
            }
          },
        );
      });
    }
  

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: Container(
              margin: EdgeInsets.all(50),
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            width: widget.size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  build_edit_field(
                    item: 'name',
                    hint: 'الاسم',
                    inputType: TextInputType.name,
                    controller: nameController,
                    validate: (value) {
                      if (value.isEmpty) {
                        return '*';
                      }
                      return null;
                    },
                    focus: focus1,
                  ),
                  build_edit_field(
                    item: 'email',
                    hint: 'الايميل',
                    inputType: TextInputType.name,
                    controller: emailController,
                    validate: (value) {
                      if (value.isEmpty) {
                        return '*';
                      }
                    },
                    focus: focus3,
                  ),
                  build_edit_field(
                    item: 'password',
                    hint: 'password',
                    // small: true,
                    inputType: TextInputType.name,
                    controller: passwordcontroller,
                    validate: (value) {
                      if (value.isEmpty) {
                        return '*';
                      }
                    },
                    focus: focus4,
                  ),
                  build_edit_field(
                      item: 'confirm_password',
                      hint: 'confirm_password',
                      // small: true,
                      inputType: TextInputType.name,
                      controller: confirmpasswordController,
                      validate: (value) {
                        if (value.isEmpty) {
                          return '*';
                        }
                      },
                      focus: focus5),
                  build_edit_field(
                    item: 'phonenumber',
                    hint: 'رقم التليفون',
                    inputType: TextInputType.name,
                    controller: phonecontroller,
                    validate: (value) {
                      if (value.isEmpty) {
                        return '*';
                      }
                      return null;
                    },
                    focus: focus2,
                  ),
                  Center(
                    child: Container(
                      width: widget.size.width * .9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Edit_Text(size: widget.size / 2, name: 'المجموعه'),
                          build_edit_field(
                              item: 'parent_name',
                              hint: 'اسم ولى الامر',
                              small: true,
                              inputType: TextInputType.name,
                              controller: parentNameController,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return '*';
                                }
                              },
                              focus: focus6),
                          build_edit_field(
                              item: 'relation',
                              hint: 'القرابه',
                              small: true,
                              inputType: TextInputType.name,
                              controller: relationController,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return '*';
                                }
                              },
                              focus: focus7),
                        ],
                      ),
                    ),
                  ),
                  if (!widget.edit!)
                    build_edit_field(
                      item: 'parentemail',
                      hint: 'ايميل ولى الامر',
                      inputType: TextInputType.emailAddress,
                      controller: parentemailController,
                      validate: (value) {
                        if (value.isEmpty) {
                          return '*';
                        }
                      },
                      focus: focus15,
                    ),
                  if (!widget.edit!)
                    build_edit_field(
                      item: 'passwordparent',
                      hint: 'parent password',
                      // small: true,
                      inputType: TextInputType.name,
                      controller: parentpasswordController,
                      validate: (value) {
                        if (value.isEmpty) {
                          return '*';
                        }
                      },
                      focus: focus16,
                    ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        build_edit_field(
                          item: 'parent_phone',
                          hint: 'رقم تليفون ولى الأمر',
                          inputType: TextInputType.phone,
                          controller: parentphoneController,
                          small: true,
                          validate: (value) {
                            if (value.isEmpty) {
                              return '*';
                            }
                          },
                          focus: focus8,
                        ),
                        build_edit_field(
                            item: 'parent_watsapp',
                            hint: 'رقم واتساب ولى الأمر',
                            inputType: TextInputType.phone,
                            controller: parentWhatsController,
                            small: true,
                            validate: (value) {
                              if (value.isEmpty) {
                                return '*';
                              }
                            },
                            focus: focus9),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: widget.size.width / 2 * .9,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                style: TextStyle(
                                    fontFamily: 'GE-medium',
                                    color: Colors.black),
                                value: _register_data['gender'],
                                hint: Text('النوع'),
                                isExpanded: true,
                                iconSize: 30,
                                onChanged: (newval) {
                                  setState(() {
                                    _register_data['gender'] =
                                        newval.toString();
                                  });
                                },
                                icon: Icon(Icons.keyboard_arrow_down),
                                items: ['أنثي', 'ذكر']
                                    .map((item) => DropdownMenuItem(
                                          child: Text(item),
                                          value: item,
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: widget.size.width / 2 * .9,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Container(
                            child: InkWell(
                              onTap: () => _modalBottomSheetMenu(context),
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      cityname,
                                      style: TextStyle(fontFamily: 'GE-light'),
                                    ),
                                    Spacer(),
                                    Icon(Icons.keyboard_arrow_down)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: widget.size.width * .9,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: InkWell(
                        onTap: () => _modalBottomSheetMenumulti(context),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        ' المجموعات الدراسيه ',
                                        style:
                                            TextStyle(fontFamily: 'GE-light'),
                                      ),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                width: widget.size.width * .9,
                                child: ListView.builder(
                                  itemCount: _groups_shown.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Text(
                                        _groups_shown[index],
                                        style:
                                            TextStyle(fontFamily: 'GE-light'),
                                      ),
                                      Text(', ')
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  build_edit_field(
                      item: 'studyType',
                      hint: 'الشعبه',
                      // small: true,
                      inputType: TextInputType.name,
                      controller: studyTypeController,
                      validate: (value) {
                        if (value.isEmpty) {
                          return '*';
                        }
                      },
                      focus: focus10),
                  build_edit_field(
                      item: 'school',
                      hint: 'المدرسه',
                      inputType: TextInputType.name,
                      controller: schoolController,
                      validate: (value) {
                        if (value.isEmpty) {
                          return '*';
                        }
                      },
                      focus: focus11),
                  Container(
                    width: widget.size.width * .9,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          build_edit_field(
                              item: 'code',
                              hint: 'الكود الخاص',
                              small: true,
                              inputType: TextInputType.text,
                              controller: barCodeController,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return '*';
                                }
                              },
                              focus: focus12),
                          Center(
                            child: InkWell(
                              onTap: () => scanBarcodeNormal(),
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: widget.size.width / 2 * .9,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                height: 40,
                                decoration: BoxDecoration(),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text('scan code  '),
                                      Icon(Icons.camera_alt_outlined),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      build_edit_field(
                          item: 'discount',
                          hint: 'الخصم',
                          small: true,
                          inputType: TextInputType.number,
                          controller: discountController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return '*';
                            }
                          },
                          focus: focus13),
                      Center(
                        child: Container(
                          alignment: Alignment.centerRight,
                          width: widget.size.width / 2 * .9,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Container(
                            child: InkWell(
                              onTap: () => _modalBottomSheetMenulang(context),
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      langname,
                                      style: TextStyle(fontFamily: 'GE-light'),
                                    ),
                                    Spacer(),
                                    Icon(Icons.keyboard_arrow_down)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Center(
                      //   child: Container(
                      //     width: widget.size.width / 2 * .9,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Container(
                      //           alignment: Alignment.centerRight,
                      //           width: widget.size.width / 2 * .9,
                      //           padding: EdgeInsets.symmetric(horizontal: 20),
                      //           height: 40,
                      //           decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.circular(20),
                      //             border: Border.all(color: Colors.grey),
                      //           ),
                      //           child: Container(
                      //             child: DropdownButtonHideUnderline(
                      //               child: DropdownButton(
                      //                 style: TextStyle(
                      //                     fontFamily: 'GE-medium',
                      //                     color: Colors.black),
                      //                 value: _register_data['language'],
                      //                 hint: Text('اللغة الثانية'),
                      //                 isExpanded: true,
                      //                 iconSize: 30,
                      //                 onChanged: (newval) {
                      //                   setState(() {
                      //                     _register_data['language'] =
                      //                         newval.toString();
                      //                   });
                      //                 },
                      //                 icon: Icon(Icons.keyboard_arrow_down),
                      //                 items: ['ألماني', 'فرنساوي']
                      //                     .map((item) => DropdownMenuItem(
                      //                           child: Text(item),
                      //                           value: item,
                      //                         ))
                      //                     .toList(),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  build_edit_field(
                      item: 'observations',
                      hint: 'ملاحظات',
                      controller: notesController,
                      inputType: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return '*';
                        }
                      },
                      focus: focus14),
                  Container(
                    width: widget.size.width * .9,
                    child: TextButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2),
                        backgroundColor: MaterialStateProperty.all(
                            widget.edit! ? Colors.red[200] : kbuttonColor2),
                      ),
                      onPressed: widget.edit! ? _modify : _submit,
                      child: widget.edit!
                          ? Text(
                              'تعديل',
                              style: TextStyle(
                                  fontFamily: 'GE-Bold', color: Colors.black),
                            )
                          : Text(
                              'تسجيل',
                              style: TextStyle(
                                  fontFamily: 'GE-Bold', color: Colors.black),
                            ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    barCodeController.text = barcodeScanRes;
    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }

  Center build_edit_field({
    required String item,
    required String hint,
    bool small = false,
    required TextEditingController controller,
    required TextInputType inputType,
    Function(String)? validate,
    FocusNode? focus,
  }) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.centerRight,
        width: small ? widget.size.width * .9 / 2 : widget.size.width * .9,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Container(
          child: TextFormField(
            textInputAction: TextInputAction.next,
            focusNode: focus,
            onSaved: (value) {
              _register_data[item] = value!;
            },
            keyboardType: inputType,
            controller: controller,
            validator: (value) => validate!(value!),
            onChanged: (value) {},
            decoration: InputDecoration(
              focusedErrorBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              errorStyle: TextStyle(
                textBaseline: TextBaseline.ideographic,
                decoration: TextDecoration.none,
                fontSize: 12,
              ),
              hintText: hint,
              hintStyle: TextStyle(fontFamily: 'GE-light', fontSize: 15),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class Edit_Text extends StatelessWidget {
  const Edit_Text(
      {Key? key,
      required this.size,
      required this.name,
      this.arrow = false,
      this.color = Colors.white,
      this.changColor = false})
      : super(key: key);

  final Size size;
  final String name;
  final bool arrow;
  final Color color;
  final bool changColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.centerRight,
        width: size.width * .9,
        // margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 40,
        // width: 300,
        decoration: BoxDecoration(
          color: changColor ? Colors.teal[100] : color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Container(
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: TextStyle(fontFamily: 'GE-medium'),
              ),
              if (arrow) Spacer(),
              if (arrow)
                Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
