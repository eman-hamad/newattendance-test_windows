import 'package:attendance/helper/httpexception.dart';
import 'package:attendance/managers/cities_manager.dart';
import 'package:attendance/managers/subject_manager.dart';
import 'package:attendance/managers/teacher_manager.dart';
import 'package:attendance/managers/year_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Teacher_Form extends StatefulWidget {
  const Teacher_Form({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _Teacher_FormState createState() => _Teacher_FormState();
}

class _Teacher_FormState extends State<Teacher_Form> {
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

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var pass1Controller = TextEditingController();
  var pass2Controller = TextEditingController();
  var phoneController = TextEditingController();
  var alternativePhoneController = TextEditingController();
  var yearsController = TextEditingController();
  var languageController = TextEditingController();
  var governomentController = TextEditingController();
  var schoolController = TextEditingController();
  var assistantphoneController = TextEditingController();
  var assisAlternativePhoneController = TextEditingController();
  var notesController = TextEditingController();
  var experienceController = TextEditingController();

  var assistantnamecontroller = TextEditingController();
  var assistantemailcontroller = TextEditingController();
  var assistantpasscontrooller = TextEditingController();

  @override
  void dispose() {
    _isLoading = false;
    nameController.dispose();
    emailController.dispose();
    pass1Controller.dispose();
    pass2Controller.dispose();
    phoneController.dispose();
    alternativePhoneController.dispose();
    yearsController.dispose();
    languageController.dispose();
    governomentController.dispose();
    schoolController.dispose();
    assistantphoneController.dispose();
    assisAlternativePhoneController.dispose();
    notesController.dispose();
    experienceController.dispose();
    assistantnamecontroller.dispose();
    assistantemailcontroller.dispose();
    assistantpasscontrooller.dispose();

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
    focus15.dispose();
    _sc.dispose();
    _sc2.dispose();
    _sc3.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = true;
  List<String> _years_ids = [];

  Map<String, dynamic> _register_data = {};

  String subjectname = 'الماده';
  String cityname = 'المحافظه';
  List<String> years_shown = [];
  late String subjectId_selected;
  late String cityId_selected;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (subjectname == 'الماده' ||
        cityname == 'المحافظه' ||
        years_shown.isEmpty) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<TeacherManager>(context, listen: false)
          .add_teacher(
              nameController.text,
              phoneController.text,
              emailController.text,
              alternativePhoneController.text,
              pass1Controller.text,
              pass2Controller.text,
              assistantphoneController.text,
              assisAlternativePhoneController.text,
              schoolController.text,
              experienceController.text,
              notesController.text,
              subjectId_selected,
              _years_ids,
              cityId_selected,
              assistantemailcontroller.text,
              assistantpasscontrooller.text,
              assistantnamecontroller.text)
          .then((_) {
        _formKey.currentState?.reset();
        nameController.text = '';
        emailController.text = '';
        pass1Controller.text = '';
        pass2Controller.text = '';
        phoneController.text = '';
        alternativePhoneController.text = '';
        yearsController.text = '';
        languageController.text = '';
        governomentController.text = '';
        schoolController.text = '';
        assistantphoneController.text = '';
        assisAlternativePhoneController.text = '';
        notesController.text = '';
        experienceController.text = '';
        assistantemailcontroller.text = '';
        assistantpasscontrooller.text = '';
        assistantnamecontroller.text = '';
        subjectname = 'الماده';
        cityname = 'المحافظه';
        subjectId_selected = '';
        cityId_selected = '';
        _years_ids = [];
        years_shown = [];
      }).then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green[300],
            content: Text(
              'تم اضافه المدرس بنجاح',
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

  ScrollController _sc = new ScrollController();
  ScrollController _sc2 = new ScrollController();
  ScrollController _sc3 = new ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      Provider.of<SubjectManager>(context, listen: false).resetlist();
      Provider.of<YearManager>(context, listen: false).resetlist();
      Provider.of<CitiesManager>(context, listen: false).resetlist();
      try {
        await Provider.of<SubjectManager>(context, listen: false)
            .getMoreData()
            .then((_) =>
                Provider.of<YearManager>(context, listen: false).getMoreData())
            .then((_) => Provider.of<CitiesManager>(context, listen: false)
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
            Provider.of<CitiesManager>(context, listen: false).getMoreData();
          }
        },
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
                            controller: _sc3,
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
                                  print('object');
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
                    'السنوات الدراسيه ',
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
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
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

                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter checkboxstate) {
                                      return ListTile(
                                        title: Text(
                                            yearmanager.years[index].name!),
                                        leading: Checkbox(
                                          onChanged: (value) {
                                            checkboxstate(() {
                                              yearmanager.years[index].choosen =
                                                  !yearmanager
                                                      .years[index].choosen!;
                                            });
                                          },
                                          value:
                                              yearmanager.years[index].choosen,
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
        _years_ids = Provider.of<YearManager>(context, listen: false)
            .years
            .where((element) => element.choosen == true)
            .toList()
            .map((e) => e.id.toString())
            .toList();
        years_shown = Provider.of<YearManager>(context, listen: false)
            .years
            .where((element) => element.choosen == true)
            .toList()
            .map((e) => e.name.toString())
            .toList();
      });
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
            // height: widget.size.height * .8,
            width: widget.size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  build_edit_field(
                      item: 'name',
                      hint: 'الاسم',
                      controller: nameController,
                      inputType: TextInputType.name,
                      validate: (value) {},
                      focus: focus1),
                  build_edit_field(
                      item: 'email',
                      hint: 'email',
                      controller: emailController,
                      inputType: TextInputType.name,
                      validate: (value) {},
                      focus: focus2),
                  build_edit_field(
                    item: 'password1',
                    hint: 'password',
                    controller: pass1Controller,
                    inputType: TextInputType.name,
                    validate: (value) {},
                    focus: focus3,
                  ),
                  build_edit_field(
                    item: 'password2',
                    hint: 'password confirmation',
                    controller: pass2Controller,
                    inputType: TextInputType.name,
                    validate: (value) {},
                    focus: focus15,
                  ),
                  build_edit_field(
                    item: 'assistant_name',
                    hint: 'اسم المساعد ',
                    controller: assistantnamecontroller,
                    inputType: TextInputType.name,
                    validate: (value) {},
                    focus: focus12,
                  ),
                  build_edit_field(
                    item: 'assitant_email',
                    hint: 'Assistant email',
                    controller: assistantemailcontroller,
                    inputType: TextInputType.name,
                    validate: (value) {},
                    focus: focus13,
                  ),
                  build_edit_field(
                    item: 'password_assistant',
                    hint: 'Assistant Password',
                    controller: assistantpasscontrooller,
                    inputType: TextInputType.name,
                    validate: (value) {},
                    focus: focus14,
                  ),
                  Center(
                    child: Container(
                      width: widget.size.width * .9,
                      child: Row(
                        children: [
                          build_edit_field(
                            item: 'Teacher_phone_number',
                            hint: 'رقم التليفون',
                            controller: phoneController,
                            inputType: TextInputType.phone,
                            small: true,
                            focus: focus5,
                          ),
                          build_edit_field(
                            item: 'Teacher_phone_number2',
                            hint: 'رقم تليفون بديل',
                            controller: alternativePhoneController,
                            inputType: TextInputType.phone,
                            small: true,
                            focus: focus6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      width: widget.size.width * .9,
                      child: Row(
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
                              child: InkWell(
                                onTap: () => _modalBottomSheetMenu(context),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        subjectname,
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
                                  onTap: () => _modalBottomSheetMenu2(context),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          cityname,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
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
                                        'السنوات الدراسيه ',
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
                                  itemCount: years_shown.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Text(
                                        years_shown[index],
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
                  Center(
                    child: Container(
                      width: widget.size.width * .9,
                      child: Row(
                        children: [
                          build_edit_field(
                            item: 'Assistant_phone_number1',
                            hint: 'رقم تليفون مساعد',
                            controller: assistantphoneController,
                            inputType: TextInputType.phone,
                            small: true,
                            focus: focus7,
                          ),
                          build_edit_field(
                            item: 'Assistant_phone_number2',
                            hint: 'رقم تليفون مساعد 2',
                            controller: assisAlternativePhoneController,
                            inputType: TextInputType.phone,
                            small: true,
                            focus: focus8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  build_edit_field(
                    item: 'school',
                    hint: 'المدرسه',
                    controller: schoolController,
                    inputType: TextInputType.text,
                    focus: focus9,
                  ),
                  build_edit_field(
                    item: 'years_experience',
                    hint: 'سنوات الخبره',
                    controller: experienceController,
                    inputType: TextInputType.number,
                    focus: focus10,
                  ),
                  build_edit_field(
                    item: 'observations',
                    hint: 'ملاحظات',
                    controller: notesController,
                    inputType: TextInputType.text,
                    focus: focus11,
                  ),
                  Container(
                    width: widget.size.width * .9,
                    child: TextButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(2),
                          backgroundColor:
                              MaterialStateProperty.all(kbuttonColor3)),
                      onPressed: _submit,
                      child: Text(
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
            // maxLength: 6,

            focusNode: focus,
            textInputAction: TextInputAction.next,
            onSaved: (value) {
              _register_data[item] = value!;
            },
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
              focusedErrorBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              errorStyle: TextStyle(
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
