import 'dart:ui';

import 'package:attendance/helper/httpexception.dart';
import 'package:attendance/managers/Auth_manager.dart';
import 'package:attendance/managers/stage_manager.dart';
import 'package:attendance/managers/year_manager.dart';
import 'package:attendance/navigation/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

import 'components/Academic_Top_Page.dart';
import 'components/default_form_field.dart';

class Add_academic_year extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Attendance_Screens.years_add,
      key: ValueKey(Attendance_Screens.years_add),
      child: Add_academic_year(),
    );
  }

  Add_academic_year({
    Key? key,
  }) : super(key: key);

  @override
  _Add_academic_yearState createState() => _Add_academic_yearState();
}

class _Add_academic_yearState extends State<Add_academic_year> {
  var yearController = TextEditingController();

  String text_value = '';
  Map<String, dynamic> _add_data = {'stage': null, 'id': null};
  var _isInit = true;
  var _isLoading = true;
  ScrollController _sc = new ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      Provider.of<YearManager>(context, listen: false).resetlist();
      try {
        await Provider.of<StageManager>(context, listen: false)
            .get_stages()
            .then((value) =>
                Provider.of<YearManager>(context, listen: false).getMoreData())
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (e) {}
      if (!mounted) return;

      _sc.addListener(() {
        if (_sc.position.pixels == _sc.position.maxScrollExtent) {
          Provider.of<YearManager>(context, listen: false).getMoreData();
        }
      });
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  void _submit() async {
    // final isValid = _formKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    if (defaultstagename == 'المرحله الدراسيه' || yearController.text == '') {
      _showErrorDialog('قم بكتابه السنه الدراسيه واختار المرحله الدراسيه');
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<YearManager>(context, listen: false)
          .add_year(yearController.text, stage_id_selected)
          .then((_) {
            _formKey.currentState?.reset();
            yearController.text = '';

            defaultstagename = 'المرحله الدراسيه';
          })
          .then((_) =>
              Provider.of<YearManager>(context, listen: false).resetlist())
          .then((_) =>
              Provider.of<YearManager>(context, listen: false).getMoreData())
          .then((_) => setState(() {
                _isLoading = false;
              }))
          .then(
            (_) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green[300],
                content: Text(
                  'تم اضافه السنه الدراسيه بنجاح',
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

  var defaultstagename = 'المرحله الدراسيه';
  late String stage_id_selected;
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
        backgroundColor: kbackgroundColor1,
        body: Column(
          children: [
            Academic_Top_Page(size: size),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 20),
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
                                // : ,
                                text: 'السنة الدراسية',
                                controller: yearController,
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
                          Container(
                            // color: Colors.green,
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: size.width / 2,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              height: 40,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                // borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: InkWell(
                                onTap: () => _modalBottomSheetMenu(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      width: (size.width / 2) * .7,
                                      child: Text(
                                        defaultstagename,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style:
                                            TextStyle(fontFamily: 'GE-light'),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.keyboard_arrow_down)
                                  ],
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
                      child: CircularProgressIndicator(),
                    ),
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
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 2,
                              blurRadius: 2,
                            ),
                          ],
                        ),
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
                              }
                            } else {
                              return ListView.separated(
                                controller: _sc,
                                separatorBuilder:
                                    (BuildContext ctxt, int index) => Divider(
                                  color: Colors.grey,
                                ),
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
                                    key: Key(
                                        yearmanager.years[index].id.toString()),
                                    onDismissed: (DismissDirection) async {
                                      try {
                                        String? subname =
                                            yearmanager.years[index].name;
                                        await Provider.of<YearManager>(context,
                                                listen: false)
                                            .deleteyear(yearmanager
                                                .years[index].id
                                                .toString());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.black45,
                                                content: Text(
                                                  'تم مسح $subname',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'GE-medium'),
                                                )));
                                      } on HttpException catch (error) {
                                        _showErrorDialog(error.toString());
                                      } catch (e) {
                                        _showErrorDialog('حاول مره اخري');
                                      }
                                    },
                                    child: ListTile(
                                      title: Text(
                                          //.stage.name
                                          yearmanager
                                              .years[index].stage!.name!),
                                      leading:
                                          Text(yearmanager.years[index].name!),
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
  //     title: const Text('اضافة سنة دراسية'),
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
  //             text: 'السنة الدراسية',
  //             controller: yearController,
  //             prefix: Icons.calendar_today,
  //             type: TextInputType.name,
  //             validate: () {},
  //           ),
  //           Container(
  //             child: StatefulBuilder(
  //               builder: (BuildContext context, StateSetter dropDownState) {
  //                 return Center(
  //                   child: Container(
  //                     alignment: Alignment.centerRight,
  //                     // width: size.width / 2,
  //                     padding: EdgeInsets.symmetric(horizontal: 20),
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(20),
  //                       border: Border.all(color: Colors.grey),
  //                     ),
  //                     child: Container(
  //                       child: InkWell(
  //                         onTap: () => _modalBottomSheetMenu(context),
  //                         child: Container(
  //                           child: Row(
  //                             children: [
  //                               Text(
  //                                 defaultstagename,
  //                                 style: TextStyle(fontFamily: 'GE-light'),
  //                               ),
  //                               Spacer(),
  //                               Icon(Icons.keyboard_arrow_down)
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 );

  //                 // DropdownButtonHideUnderline(
  //                 //   child: DropdownButton(
  //                 //     style: TextStyle(
  //                 //         fontFamily: 'GE-medium', color: Colors.black),
  //                 //     value: _add_data['stage'],
  //                 //     hint: Text('المرحله الدراسية'),
  //                 //     isExpanded: true,
  //                 //     iconSize: 30,
  //                 //     onChanged: (newval) {
  //                 //       dropDownState(() {
  //                 //         _add_data['stage'] = newval;
  //                 //       });
  //                 //     },
  //                 //     icon: Icon(Icons.keyboard_arrow_down),
  //                 //     items: Provider.of<StageManager>(context, listen: false)
  //                 //         .stages!
  //                 //         .map((item) => DropdownMenuItem(
  //                 //               child: Text(item.name!),
  //                 //               value: item.name!,
  //                 //               onTap: () {
  //                 //                 setState(() {
  //                 //                   _add_data['id'] = item.id;
  //                 //                   // print(_add_data['id']);
  //                 //                 });
  //                 //               },
  //                 //             ))
  //                 //         .toList(),
  //                 //   ),
  //                 // );
  //               },
  //             ),
  //           ),
  //           Spacer(),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               ElevatedButton(
  //                   style: ElevatedButton.styleFrom(primary: kbackgroundColor1),
  //                   onPressed: () {
  //                     setState(() {
  //                       text_value = yearController.text;
  //                     });
  //                     if (_add_data['stage'] == null) return;
  //                     if (text_value == '') return;
  //                     Provider.of<YearManager>(context, listen: false)
  //                         .add_year(text_value, _add_data['id']!.toString())
  //                         .then((value) => Navigator.of(context).pop())
  //                         .then(
  //                           (value) => setState(() {
  //                             _isLoading = true;
  //                           }),
  //                         )
  //                         .then((value) {
  //                       Provider.of<YearManager>(context, listen: false)
  //                           .getMoreData();
  //                     }).then((value) {
  //                       setState(() {
  //                         _isLoading = false;
  //                       });
  //                     });
  //                     // litems.add(text_value);
  //                     yearController.clear();
  //                   },
  //                   child: Text(
  //                     'اضافة',
  //                     style: TextStyle(
  //                         color: Colors.black, fontFamily: 'GE-medium'),
  //                   )),
  //               SizedBox(
  //                 width: 20,
  //               ),
  //               ElevatedButton(
  //                 style: ElevatedButton.styleFrom(primary: kbackgroundColor1),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text(
  //                   'الغاء',
  //                   style:
  //                       TextStyle(color: Colors.black, fontFamily: 'GE-medium'),
  //                 ),
  //               ),
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
                    color: kbackgroundColor1,
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
                    child: Consumer<StageManager>(
                      builder: (_, stagemanager, child) {
                        if (stagemanager.stages!.isEmpty) {
                          if (stagemanager.loading) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ));
                          } else if (stagemanager.error) {
                            return Center(
                                child: InkWell(
                              onTap: () {
                                stagemanager.setloading(true);
                                stagemanager.seterror(false);
                                Provider.of<StageManager>(context,
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
                            itemCount: stagemanager.stages!.length +
                                (stagemanager.hasmore ? 1 : 0),
                            itemBuilder: (BuildContext ctxt, int index) {
                              if (index == stagemanager.stages!.length) {
                                if (stagemanager.error) {
                                  return Center(
                                      child: InkWell(
                                    onTap: () {
                                      stagemanager.setloading(true);
                                      stagemanager.seterror(false);
                                      Provider.of<StageManager>(context,
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
                                    stage_id_selected = stagemanager
                                        .stages![index].id
                                        .toString();
                                    defaultstagename =
                                        stagemanager.stages![index].name!;
                                  });
                                  Navigator.pop(context);
                                },
                                child: ListTile(
                                  title:
                                      Text(stagemanager.stages![index].name!),
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
