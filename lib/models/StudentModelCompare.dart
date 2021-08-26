import 'package:attendance/models/subject.dart';

class StudentModelCompare {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? school;
  String? note;
  String? parent;
  String? relationType;
  String? parentPhone;
  String? parentWhatsapp;
  String? gender;
  String? studyType;
  
  String? discount;

  String? localed_type;
 

  StudentModelCompare({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.school,
    this.note,
    // this.city,
    // this.groups,
    this.parent,
    this.relationType,
    this.parentPhone,
    this.parentWhatsapp,
    this.gender,
    this.studyType,
    // this.secondLanguage,
    this.discount,
    this.localed_type,
   
  });

  StudentModelCompare.fromJson(Map<String, dynamic> json) {
    
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    school = json['school'];
    note = json['note'];
    discount = json['discount'];
    localed_type = json['localed_type'];


    // groups = List<GroupModel>.from(
    //   json['groups'].map(
    //     (model) => GroupModel.fromJson(model),
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
    discount = json['discount'] ?? '';
    // code = json['code'] != null ? new Code.fromJson(json['code']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['school'] = this.school;
    data['note'] = this.note;

    data['localed_type'] = this.localed_type;
   
    
    return data;
  }
}
