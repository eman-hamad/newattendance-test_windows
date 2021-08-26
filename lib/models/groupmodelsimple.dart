import 'package:attendance/models/simpleteacher.dart';
import 'package:attendance/models/subject.dart';
import 'package:attendance/models/teacher.dart';
import 'package:attendance/models/year.dart';

class GroupModelSimple {
  int? id;
  String? name;
  YearModel? year;
  SimpleTeacher? teacher;
  SubjectModel? subject;
  List<dynamic>? time;
  List<dynamic>? day;
  bool? choosen;
  // List<AppointmentModel>? appointments;

  GroupModelSimple(
      {this.id,
      this.year,
      this.teacher,
      this.day,
      this.time,
      this.name,
      this.subject,
      // this.appointments,
      this.choosen = false});

  GroupModelSimple.fromJson(Map<String, dynamic> json) {
    choosen = false;

    id = json['id'];
    name = json['name'];
    year = json['year'] != null ? new YearModel.fromJson(json['year']) : null;
    subject = json['subject'] != null
        ? new SubjectModel.fromJson(json['subject'])
        : null;
    teacher = json['teacher'] != null
        ? new SimpleTeacher.fromJson(json['teacher'])
        : null;
    // appointments = List<AppointmentModel>.from(
    //   json['appointments'].map(
    //     (model) => AppointmentModel.fromJson(model),
    //   ),
    // );

    time = json['time'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.year != null) {
      data['year'] = this.year!.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    // if (this.appointments != null) {
    //   data['appointments'] = this.appointments!.map((v) => v.toJson()).toList();
    // }

    data['time'] = this.time;
    data['day'] = this.day;
    return data;
  }
}
