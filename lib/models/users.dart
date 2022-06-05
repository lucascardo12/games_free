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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['token'] = token;

    return data;
  }
}
