import 'stage.dart';

class YearModel {
  int? id;
  String? name;
  bool? choosen;
  Stage? stage;

  YearModel({this.id, this.name, this.stage, this.choosen = false});

  YearModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stage = json['stage'] != null ? new Stage.fromJson(json['stage']) : null;
    choosen = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['choosen'] = false;
    data['name'] = this.name;
    if (this.stage != null) {
      data['stage'] = this.stage!.toJson();
    }
    return data;
  }
}
