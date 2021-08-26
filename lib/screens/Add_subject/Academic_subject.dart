import 'dart:ui';

import 'package:attendance/helper/httpexception.dart';
import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/managers/subject_manager.dart';
import 'package:attendance/managers/year_manager.dart';
import 'package:attendance/navigation/screens.dart';
import 'package:attendance/screens/Add_subject/components/subject_Top_Page.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:provider/provider.dart';

import 'components/default_form_field.dart';

class Add_academic_subject extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Attendance_Screens.subjects_add,
      key: ValueKey(Attendance_Screens.subjects_add),
      child: Add_academic_subject(),
    );
  }

  Add_academic_subject({
    Key? key,
  }) : super(key: key);

  @override
  _Add_academic_subjectState createState() => _Add_academic_subjectState();
}

class _Add_academic_subjectState extends State<Add_academic_subject> {
  List<String> litems = [];

  Map<String, dynamic> _add_data = {
    'year': null,
    'id': null,
  };
  var _isInit = true;
  var _isLoading = true;
  ScrollController _sc = new ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      Provider.of<SubjectManager>(context, listen: false).resetlist();
      try {
        await Provider.of<YearManager>(context, listen: false)
            .get_years()
            .then((_) => Provider.of<SubjectManager>(context, listen: false)
                .getMoreData())
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (e) {}
      if (!mounted) return;

      _sc.addListener(() {
        if (_sc.position.pixels == _sc.position.maxScrollExtent) {
          Provider.of<SubjectManager>(context, listen: false).getMoreData();
        }
      });
    });
  }

  void _submit() async {
    // final isValid = _formKey.currentState!.validate();
    // if (!isValid) {
    //   print('object');
    //   return;
    // }
    if (defaultyearname == 'السنه الدراسيه' || subjectController.text == '') {
      _showErrorDialog('قم بكتابه الماده واختار السنه الدراسيه');
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<SubjectManager>(context, listen: false)
          .add_subject(subjectController.text, year_id_selected)
          .then((_) {
            _formKey.currentState?.reset();
            subjectController.text = '';

            defaultyearname = 'السنه الدراسيه';
          })
          .then((_) =>
              Provider.of<SubjectManager>(context, listen: false).resetlist())
          .then((_) =>
              Provider.of<SubjectManager>(context, listen: false).getMoreData())
          .then((_) => setState(() {
                _isLoading = false;
              }))
          .then(
            (_) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green[300],
                content: Text(
                  'تم اضافه الماده الدراسيه بنجاح',
                  style: TextStyle(fontFamily: 'GE-medium'),
                ),
                duration: Duration(seconds: 3),
              ),
            ),
          );
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      const errorMessage = 'حاول مره اخري';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
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
                      MaterialStateProperty.all(kbackgroundColor3)),
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

  final GlobalKey<FormState> _formKey = GlobalKey();

  var subjectController = TextEditingController();

  String text_value = '';
  String defaultyearname = 'السنه الدراسيه';
  late String year_id_selected;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: _isLoading
            ? null
            : FloatingActionButton(
                onPressed: _submit,
                child: Icon(Icons.add),
              ),
        backgroundColor: kbackgroundColor3,
        body: Column(
          children: [
            Subject_Top_Page(size: size),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 50),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Provider.of<Auth_manager>(context, listen: false).name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            fontFamily: 'AraHamah1964B-Bold'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Form(
                            key: _formKey,
                            child: Container(
                              height: 40,
                              width: size.width / 2,
                              child: defaultFormField(
                                text: 'الماده الدراسية',
                                controller: subjectController,
                                prefix: Icons.calendar_today,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return '*';
                                  }
                                },
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: size.width / 2,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Container(
                                child: InkWell(
                                  onTap: () => _modalBottomSheetMenu(context),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          defaultyearname,
                                          style:
                                              TextStyle(fontFamily: 'GE-light'),
                                        ),
                                        Spacer(),
                                        Icon(Icons.keyboard_arrow_down)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _isLoading
                ? Center(
                    child: Container(
                        margin: EdgeInsets.all(50),
                        child: CircularProgressIndicator()),
                  )
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          // vertical: 10,
                          horizontal: 15,
                        ),
                        width: MediaQuery.of(context).size.width * .95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 2,
                              blurRadius: 2,
                            ),
                          ],
                        ),
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
                                    child:
                                        Text("error please tap to try again"),
                                  ),
                                ));
                              }
                            } else {
                              return ListView.separated(
                                controller: _sc,
                                separatorBuilder:
                                    (BuildContext ctxt, int index) => Divider(
                                  color: Colors.grey,
                                ),
                                itemCount: subjectmanager.subjects!.length +
                                    (subjectmanager.hasmore ? 1 : 0),
                                itemBuilder: (BuildContext ctxt, int index) {
                                  if (index ==
                                      subjectmanager.subjects!.length) {
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

                                  return Dismissible(
                                    background: Container(
                                      color: Colors.red,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    key: Key(subjectmanager.subjects![index].id
                                        .toString()),
                                    onDismissed: (DismissDirection) async {
                                      try {
                                        String? subname = subjectmanager
                                            .subjects![index].name;
                                        await Provider.of<SubjectManager>(
                                                context,
                                                listen: false)
                                            .deletesubject(subjectmanager
                                                .subjects![index].id
                                                .toString());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.black45,
                                                content: Text('تم مسح $subname',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'GE-medium'))));
                                      } on HttpException catch (error) {
                                        _showErrorDialog(error.toString());
                                      } catch (e) {
                                        _showErrorDialog('حاول مره اخري');
                                      }
                                    },
                                    child: ListTile(
                                      title: Text(subjectmanager
                                          .subjects![index].name!),
                                      leading: Text(
                                          //.stage.name
                                          subjectmanager
                                              .subjects![index].year!.name!),
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
                  ),
          ],
        ),
      ),
    );
  }

  // Widget _buildPopupDialog(BuildContext context) {
  //   return new AlertDialog(
  //     title: const Text('اضاف السنة و المادة الدراسية'),
  //     content: new Container(
  //       height: 180,
  //       width: 180,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.zero),
  //         color: Colors.white,
  //       ),
  //       child: Column(
  //         children: [
  //           defaultFormField(
  //             text: 'المادة الدراسية',
  //             controller: yearController,
  //             prefix: Icons.calendar_today,
  //             type: TextInputType.name,
  //             validate: () {},
  //           ),
  //           Container(
  //             child: StatefulBuilder(
  //               builder: (BuildContext context, StateSetter dropDownState) {
  //                 return DropdownButtonHideUnderline(
  //                   child: DropdownButton(
  //                     style: TextStyle(
  //                         fontFamily: 'GE-medium', color: Colors.black),
  //                     value: _add_data['year'],
  //                     hint: Text('المواد الدراسية'),
  //                     isExpanded: true,
  //                     iconSize: 30,
  //                     onChanged: (newval) {
  //                       // setState(() {
  //                       //   _add_data['year'] = newval.toString();
  //                       // });
  //                       dropDownState(() {
  //                         _add_data['year'] = newval;
  //                       });
  //                     },
  //                     icon: Icon(Icons.keyboard_arrow_down),
  //                     items: Provider.of<YearManager>(context, listen: false)
  //                         .years
  //                         .map(
  //                           (item) => DropdownMenuItem(
  //                             child: Text(item.name!),
  //                             value: item.name!,
  //                             onTap: () {
  //                               setState(() {
  //                                 _add_data['id'] = item.id;
  //                               });
  //                             },
  //                           ),
  //                         )
  //                         .toList(),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //           Spacer(),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               ElevatedButton(
  //                   style: ElevatedButton.styleFrom(primary: kbackgroundColor4),
  //                   onPressed: () {
  //                     setState(() {
  //                       text_value = yearController.text;
  //                     });
  //                     if (_add_data['year'] == null) return;
  //                     if (text_value == '') return;
  //                     Provider.of<SubjectManager>(context, listen: false)
  //                         .add_subject(text_value, _add_data['id']!.toString())
  //                         .then((value) => Navigator.of(context).pop())
  //                         .then((_) {
  //                           setState(() {
  //                             _isLoading = true;
  //                           });
  //                         })
  //                         .then((value) => Provider.of<SubjectManager>(context,
  //                                 listen: false)
  //                             .getMoreData())
  //                         .then((value) {
  //                           setState(() {
  //                             _isLoading = false;
  //                           });
  //                         });
  //                     // litems.add(text_value);
  //                     yearController.clear();
  //                   },
  //                   child: Text(
  //                     'اضافة',
  //                     style: TextStyle(fontWeight: FontWeight.bold),
  //                   )),
  //               SizedBox(
  //                 width: 20,
  //               ),
  //               ElevatedButton(
  //                   style: ElevatedButton.styleFrom(primary: kbackgroundColor4),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text('الغاء')),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
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
                      'المرحله الدراسيه',
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
                            controller: _sc,
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
                                    defaultyearname =
                                        yearmanager.years[index].name!;
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
}
