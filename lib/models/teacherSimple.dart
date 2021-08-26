import 'year.dart';

class TeacherModelSimple {
  int? id;
  String? name;
  String? phone;
  String? email;

  String? school;
  String? experience;

  TeacherModelSimple({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.school,
    this.experience,
  });

  TeacherModelSimple.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];

    school = json['school'];
    experience = json['experience'];

    if (json['years'] != null) {
      List<YearModel> years = [];
      json['years'].forEach((v) {
        years.add(new YearModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;

    data['school'] = this.school;
    data['experience'] = this.experience;

    return data;
  }
}
