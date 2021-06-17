class Users {
  String? id;
  late String token;

  Users({
    this.id,
    required this.token,
  });

  Users.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['token'] = this.token;

    return data;
  }
}
