import 'package:attendance/models/appointment.dart';
import 'package:attendance/models/city.dart';
// import 'package:attendance/models/group.dart';
import 'package:attendance/models/groupmodelsimple.dart';
import 'package:attendance/models/subject.dart';
import 'package:attendance/models/subjectModelSimple.dart';

import 'code.dart';

class StudentModelSearch {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? school;
  String? note;
  City? city;
  List<GroupModelSimple>? groups;
  String? parent;
  String? relationType;
  String? parentPhone;
  String? parentWhatsapp;
  String? gender;
  String? studyType;
  // String? secondLanguage;
  String? discount;
  Code? code;
  SubjectModelSimple? secLang;
  bool? choosen;
  // List<AppointmentModel>? appointments;

  StudentModelSearch({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.school,
    this.note,
    this.city,
    this.groups,
    this.parent,
    this.relationType,
    this.parentPhone,
    this.parentWhatsapp,
    this.gender,
    this.studyType,
    // this.secondLanguage,
    this.discount,
    this.code,
    this.secLang,
    // this.appointments,
    this.choosen = false,
  });

  StudentModelSearch.fromJson(Map<String, dynamic> json) {
    choosen = false;
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    school = json['school'];
    note = json['note'];
    city = json['city_id'] != null ? new City.fromJson(json['city_id']) : null;
    secLang = (json['second_language'] != null
        ? new SubjectModelSimple.fromJson(json['second_language'])
        : null);

    groups = List<GroupModelSimple>.from(
      json['groups'].map(
        (model) => GroupModelSimple.fromJson(model),
      ),
    );
    // appointments = List<AppointmentModel>.from(
    //   json['appointments'].map(
    //     (model) => AppointmentModel.fromJson(model),
    //   ),
    // );

    // if (json['groups'] != null) {
    //   List<GroupModel> groups = [];
    //   json['groups'].forEach((v) {
    //     groups.add(new GroupModel.fromJson(v));
    //   });
    // }
    parent = json['parent'];
    relationType = json['relation_type'];
    parentPhone = json['parent_phone'];
    parentWhatsapp = json['parent_whatsapp'];
    gender = json['gender'];
    studyType = json['study_type'];
    // secondLanguage = json['second_language'];
    discount = json['discount'];
    code = json['code'] != null ? new Code.fromJson(json['code']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['school'] = this.school;
    data['note'] = this.note;
    if (this.city != null) {
      data['city_id'] = this.city!.toJson();
    }
    if (this.secLang != null) {
      data['second_language'] = this.secLang!.toJson();
    }
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    }
    // if (this.appointments != null) {
    //   data['appointments'] = this.appointments!.map((v) => v.toJson()).toList();
    // }
    data['parent'] = this.parent;
    data['relation_type'] = this.relationType;
    data['parent_phone'] = this.parentPhone;
    data['parent_whatsapp'] = this.parentWhatsapp;
    data['gender'] = this.gender;
    data['study_type'] = this.studyType;
    // data['second_language'] = this.secondLanguage;
    data['discount'] = this.discount;
    if (this.code != null) {
      data['code'] = this.code!.toJson();
    }
    return data;
  }
}
