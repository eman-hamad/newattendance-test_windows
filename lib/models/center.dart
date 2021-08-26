class Center_Admin {
  int? id;
  String? name;
  String? email;
  String? phone;

  Center_Admin({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  Center_Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;

    return data;
  }
}
