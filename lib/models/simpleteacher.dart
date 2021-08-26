import 'package:attendance/models/city.dart';

import 'subject.dart';
import 'year.dart';

class SimpleTeacher {
  int? id;
  String? name;
  String? phone;
  String? email;
  // String? phone2;
  // String? password;
  // String? passwordConfirmation;
  // String? assistantPhone;
  // String? assistantPhone2;
  String? school;
  String? experience;
  // String? note;
  // SubjectModel? subject;
  // List<YearModel>? years;
  // City? cityId;

  SimpleTeacher({
    this.id,
    this.name,
    this.phone,
    this.email,
    // this.phone2,
    // this.password,
    // this.passwordConfirmation,
    // this.assistantPhone,
    // this.assistantPhone2,
    this.school,
    this.experience,
    // this.note,
    // this.subject,
    // this.years,
    // this.cityId,
  });

  SimpleTeacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    // phone2 = json['phone2'];
    // password = json['password'];
    // passwordConfirmation = json['password_confirmation'];
    // assistantPhone = json['assistant_phone'];
    // assistantPhone2 = json['assistant_phone2'];
    school = json['school'];
    experience = json['experience'];
    // note = json['note'];
    // subject = json['subject'] != null
    //     ? new SubjectModel.fromJson(json['subject'])
    //     : null;
    // if (json['years'] != null) {
    //   List<YearModel> years = [];
    //   json['years'].forEach((v) {
    //     years.add(new YearModel.fromJson(v));
    //   });
    // }
    // cityId =
    //     json['city_id'] != null ? new City.fromJson(json['city_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    // data['phone2'] = this.phone2;
    // data['password'] = this.password;
    // data['password_confirmation'] = this.passwordConfirmation;
    // data['assistant_phone'] = this.assistantPhone;
    // data['assistant_phone2'] = this.assistantPhone2;
    data['school'] = this.school;
    data['experience'] = this.experience;
    // data['note'] = this.note;
    // if (this.subject != null) {
    //   data['subject'] = this.subject!.toJson();
    // }
    // if (this.years != null) {
    //   data['years'] = this.years!.map((v) => v.toJson()).toList();
    // }
    // data['city_id'] = this.cityId;
    return data;
  }
}
