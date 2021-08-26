import 'year.dart';

class SubjectModel {
  int? id;
  String? name;
  YearModel? year;

  SubjectModel({this.id, this.name, this.year});

  SubjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'] != null ? new YearModel.fromJson(json['year']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.year != null) {
      data['year'] = this.year!.toJson();
    }
    return data;
  }
}
