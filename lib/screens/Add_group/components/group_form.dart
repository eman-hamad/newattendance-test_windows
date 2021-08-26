import 'package:attendance/constants.dart';
import 'package:attendance/helper/httpexception.dart';
import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/managers/group_manager.dart';
import 'package:attendance/managers/subject_manager.dart';
import 'package:attendance/managers/teacher_manager.dart';
import 'package:attendance/managers/year_manager.dart';
import 'package:attendance/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class group_form extends StatefulWidget {
  const group_form({
    Key? key,
    required this.size,
    this.tuser,
    this.teacher,
  }) : super(key: key);

  final Size size;
  final user? tuser;
  final TeacherModel? teacher;

  @override
  _group_formState createState() => _group_formState();
}

class _group_formState extends State<group_form> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode fnode = FocusNode();
  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (subjectname == 'الماده الدراسيه' ||
        teachername == 'المدرس' ||
        yearname == 'السنه الدراسيه') {
      _showErrorDialog('من فضلك استكمل بيانات المجموعه', 'حدث خطا');
      return;
    }
    var _newlist1 = _data.where((e) => e != null).toList();
    List<String> _newlist = _newlist1.map((s) => s as String).toList();
    List _newnewlist = [];
    _newlist.forEach((e) {
      var _newnewlist = _newlist;
      if (e == 'سبت')
        _newnewlist.asMap().forEach((index, value) {
          if (value == e) _newnewlist[index] = 'Saturday';
        });
      if (e == 'أحد')
        _newnewlist.asMap().forEach((index, value) {
          if (value == e) _newnewlist[index] = 'Sunday';
        });
      if (e == 'اثنين')
        _newnewlist.asMap().forEach((index, value) {
          if (value == e) _newnewlist[index] = 'Monday';
        });
      if (e == 'ثلاثاء')
        _newnewlist.asMap().forEach((index, value) {
          if (value == e) _newnewlist[index] = 'Tuesday';
        });
      if (e == 'أربعاء')
        _newnewlist.asMap().forEach((index, value) {
          if (value == e) _newnewlist[index] = 'Wednesday';
        });
      if (e == 'خميس')
        _newnewlist.asMap().forEach((index, value) {
          if (value == e) _newnewlist[index] = 'Thursday';
        });
      if (e == 'جمعه')
        _newnewlist.asMap().forEach((index, value) {
          if (value == e) _newnewlist[index] = 'Friday';
        });
    });
    // print(_newnewlist);

    if (_newlist.isEmpty) {
      _showErrorDialog('من فضلك أضف مواعيد المجموعه', 'حدث خطا');

      return;
    }
    List inds = [];

    _data.asMap().forEach((index, value) {
      if (value != null) {
        inds.add(index);
      }
    });
    List<TimeOfDay> _newtimes = [];
    List newtimes = [];
    _times.asMap().forEach((index, value) {
      if (index != 0) {
        newtimes.add(value);
      }
    });
    newtimes.asMap().forEach((index, value) {
      inds.forEach((element) {
        if (index == element) {
          _newtimes.add(value);
        }
      });
    });

    print(_newlist.join(',')); // list of days (good)

    String formatTimeOfDay(TimeOfDay tod) {
      final now = new DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
      final format = DateFormat('hh:mm'); //"6:00 AM"
      return format.format(dt);
    }

    List<String> _finaltimes = [];
    _newtimes.forEach((t) {
      _finaltimes.add(formatTimeOfDay(t));
    });
    print(_finaltimes.join(','));

    // print(formatTimeOfDay(TimeOfDay.now()));
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<GroupManager>(context, listen: false)
          .addgroup(
            nameController.text,
            year_id_selected,
            subjectId_selected,
            teacher_id_selected,
            _newlist,
            _finaltimes,
          )
          .then((_) {
            nameController.text = '';
            subjectname = 'الماده الدراسيه';
            teachername = 'المدرس';
            yearname = 'السنه الدراسيه';
          })
          .then((value) => setState(() {
                _isLoading = false;
              }))
          .then(
            (_) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green[300],
                content: Text(
                  'تم اضافه المجموعه بنجاح',
                  style: TextStyle(fontFamily: 'GE-medium'),
                ),
                duration: Duration(seconds: 3),
              ),
            ),
          );
    } on HttpException catch (error) {
      _showErrorDialog('حاول مره اخري ', 'حدث خطأ');
    } catch (error) {
      _showErrorDialog('حاول مره اخري ', 'حدث خطأ');
    }
    setState(() {
      _isLoading = false;
    });
  }

  var _isLoading = false;
  Map<String, dynamic> _register_data = {
    'name': '',
    'subject': null,
    'teacher': null,
    'year_level': null,
  };
  List<int> days = [];
  var day_selected = null;
  int count = 1;
  List<dynamic> _data = [null, null, null, null, null, null, null, null];
  List<String> weekdays = [
    'سبت',
    'أحد',
    'اثنين',
    'ثلاثاء',
    'أربعاء',
    'خميس',
    'جمعه',
  ];
  List<TimeOfDay> _times = [
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now(),
  ];

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime(int e) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _times[e] = newTime;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _sc.dispose();
    _sc2.dispose();
    _sc3.dispose();

    super.dispose();
  }

  var nameController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 7),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _showErrorDialog(String message, String title) {
    showDialog(
      context: context,
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

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      Provider.of<SubjectManager>(context, listen: false).resetlist();
      Provider.of<YearManager>(context, listen: false).resetlist();
      Provider.of<TeacherManager>(context, listen: false).resetlist();
      if (widget.tuser == user.teacher) {
        teachername = widget.teacher!.name!;
        teacher_id_selected = widget.teacher!.id!.toString();
      }
      try {
        await Provider.of<SubjectManager>(context, listen: false)
            .getMoreData()
            .then((_) =>
                Provider.of<YearManager>(context, listen: false).getMoreData())
            .then((_) => Provider.of<TeacherManager>(context, listen: false)
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
            Provider.of<SubjectManager>(context, listen: false).getMoreData();
          }
        },
      );
      _sc2.addListener(
        () {
          if (_sc2.position.pixels == _sc2.position.maxScrollExtent) {
            Provider.of<YearManager>(context, listen: false).getMoreData();
          }
        },
      );
      _sc3.addListener(
        () {
          if (_sc3.position.pixels == _sc3.position.maxScrollExtent) {
            Provider.of<TeacherManager>(context, listen: false).getMoreData();
          }
        },
      );
    });
  }

  late String subjectId_selected;
  String subjectname = 'الماده الدراسيه';
  late String teacher_id_selected;
  String teachername = 'المدرس';
  late String year_id_selected;
  String yearname = 'السنه الدراسيه';
  ScrollController _sc = new ScrollController();
  ScrollController _sc2 = new ScrollController();
  ScrollController _sc3 = new ScrollController();

  void _modalBottomSheetMenu(BuildContext context) {
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
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbackgroundColor3,
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
                                    subjectId_selected = subjectmanager
                                        .subjects![index].id
                                        .toString();
                                    subjectname =
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

  void _modalBottomSheetMenu2(BuildContext context) {
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
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbackgroundColor1,
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
                    child: Consumer<YearManager>(
                      builder: (_, yearmanager, child) {
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
                          return ListView.builder(
                            controller: _sc2,
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
                                onTap: () {
                                  setState(() {
                                    year_id_selected =
                                        yearmanager.years[index].id.toString();
                                    yearname = yearmanager.years[index].name!;
                                  });
                                  Navigator.pop(context);
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

  void _modalBottomSheetMenu3(BuildContext context) {
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
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kbuttonColor2,
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
                                    teacher_id_selected = teachermanager
                                        .teachers[index].id
                                        .toString();
                                    teachername =
                                        teachermanager.teachers[index].name!;
                                  });
                                  Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: widget.size.height * .9,
            width: widget.size.width,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: widget.size.height * .3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 1,
                        ),
                        build_edit_field(
                            item: 'name',
                            hint: 'الاسم',
                            inputType: TextInputType.name,
                            controller: nameController),
                        Center(
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: widget.size.width * .9,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: InkWell(
                              onTap: () => _modalBottomSheetMenu(context),
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      subjectname,
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
                        Center(
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: widget.size.width * .9,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: InkWell(
                              onTap: widget.tuser != user.teacher
                                  ? () => _modalBottomSheetMenu3(context)
                                  : () {},
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      teachername,
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
                        Center(
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: widget.size.width * .9,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: InkWell(
                              onTap: () => _modalBottomSheetMenu2(context),
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      yearname,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    height: widget.size.height * .4,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (days.length < 7) {
                                  days.add(count);
                                  count++;
                                  print(_data);
                                  print(_times);
                                }
                              });
                            },
                            child: Center(
                              child: Container(
                                width: widget.size.width * .6,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: kbuttonColor2.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Align(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'اضافه موعد',
                                        style:
                                            TextStyle(fontFamily: 'GE-light'),
                                      ),
                                      Icon(Icons.add)
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Dismissible(
                            background: Container(
                              // color: Colors.red,
                              child: Icon(
                                Icons.delete,
                                color: Colors.red[400],
                                size: 30,
                              ),
                            ),
                            key: UniqueKey(),
                            onDismissed: (DismissDirection direction) {
                              setState(() {
                                _data = [
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                ];
                                count = 1;
                                days = [];
                                _times = [
                                  TimeOfDay.now(),
                                  TimeOfDay.now(),
                                  TimeOfDay.now(),
                                  TimeOfDay.now(),
                                  TimeOfDay.now(),
                                  TimeOfDay.now(),
                                  TimeOfDay.now(),
                                  TimeOfDay.now(),
                                ];
                              });
                            },
                            child: Container(
                              height: widget.size.height * .3,
                              child: ListView(
                                  children: days
                                      .map(
                                        (e) => Center(
                                          child: Container(
                                            width: widget.size.width * .9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width:
                                                        widget.size.width / 2.5,
                                                    // width: widget.size.width /
                                                    //     3 *
                                                    //     .9,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      // borderRadius:
                                                      //     BorderRadius.circular(20),
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                    ),
                                                    child: Container(
                                                      // color: Colors.red,
                                                      // width: 50,
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'GE-medium',
                                                              color:
                                                                  Colors.black),
                                                          value: _data[e - 1],
                                                          hint: Text('اليوم'),
                                                          isExpanded: true,
                                                          iconSize: 20,
                                                          onChanged: (newval) {
                                                            setState(() {
                                                              _data[
                                                                  e -
                                                                      1] = newval
                                                                  .toString();
                                                            });
                                                          },
                                                          icon: Icon(Icons
                                                              .keyboard_arrow_down),
                                                          items: weekdays
                                                              .map((item) =>
                                                                  DropdownMenuItem(
                                                                    child: Text(
                                                                        item),
                                                                    value: item,
                                                                  ))
                                                              .toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () => _selectTime(e),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width: widget.size.width /
                                                        3 *
                                                        .9,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: kbackgroundColor3,
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                    ),
                                                    child: Text(
                                                      '${_times[e].format(context)}',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'GE-medium',
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  Container(
                    // height: widget.size.height*,
                    height: 50,
                    child: Column(
                      children: [
                        Spacer(),
                        Container(
                          // color: Colors.red,
                          width: widget.size.width * .9,
                          // margin: EdgeInsets.symmetric(vertical: 1),
                          child: TextButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(2),
                                backgroundColor:
                                    MaterialStateProperty.all(kbuttonColor2)),
                            onPressed: _submit,
                            child: Text(
                              'تسجيل',
                              style: TextStyle(
                                  fontFamily: 'GE-light', color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: .5,
                  // )
                ],
              ),
            ),
          );
  }

  Center build_edit_field({
    required String item,
    required String hint,
    bool small = false,
    required TextEditingController controller,
    required TextInputType inputType,
  }) {
    return Center(
      child: Container(
        alignment: Alignment.centerRight,
        width: small ? widget.size.width * .9 / 2 : widget.size.width * .9,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Container(
          child: TextFormField(
            // focusNode: fnode,
            onSaved: (value) {
              _register_data[item] = value!;
            },
            // onTap: on_tap,

            keyboardType: inputType,
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return '*';
              }
              return null;
            },
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'GE-medium',
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
