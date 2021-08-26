class AppointmentModelSimple {
  int? id;
  bool? attend;
  String? degree;
  String? time;
  String? date;
  String? name;
  String? compensationId;

  AppointmentModelSimple(
      {this.id,
      this.attend,
      this.degree,
      this.compensationId,
      this.time,
      this.name,
      this.date});

  AppointmentModelSimple.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attend = json['attend'];
    degree = json['degree'];
    time = json['time'];
    date = json['date'];
    name = json['name'];
    compensationId = json['compensation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attend'] = this.attend;
    data['degree'] = this.degree;
    data['time'] = this.time;
    data['date'] = this.date;
    data['name'] = this.name;
    data['compensation_id'] = this.compensationId;
    return data;
  }
}
