import 'package:attendance/models/city.dart';
import 'package:attendance/models/group.dart';

import 'code.dart';

class StudentModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? school;
  String? note;
  City? city;
  List<GroupModel>? groups;
  String? parent;
  String? relationType;
  String? parentPhone;
  String? parentWhatsapp;
  String? gender;
  String? studyType;
  String? secondLanguage;
  String? discount;
  Code? code;
  bool? choosen;

  StudentModel({
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
    this.secondLanguage,
    this.discount,
    this.code,
    this.choosen = false,
  });

  StudentModel.fromJson(Map<String, dynamic> json) {
    choosen = false;
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    school = json['school'];
    note = json['note'];
    city = json['city_id'] != null ? new City.fromJson(json['city_id']) : null;

    groups = List<GroupModel>.from(
      json['groups'].map(
        (model) => GroupModel.fromJson(model),
      ),
    );

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
    secondLanguage = json['second_language'];
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
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    }
    data['parent'] = this.parent;
    data['relation_type'] = this.relationType;
    data['parent_phone'] = this.parentPhone;
    data['parent_whatsapp'] = this.parentWhatsapp;
    data['gender'] = this.gender;
    data['study_type'] = this.studyType;
    data['second_language'] = this.secondLanguage;
    data['discount'] = this.discount;
    if (this.code != null) {
      data['code'] = this.code!.toJson();
    }
    return data;
  }
}
