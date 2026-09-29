class User {
  String id = "";
  String sid = "";
  String name = "";
  String? email;
  String? phone;
  String? image;
  int? roleId;
  int? status;

  //Create a singleton instance of this class
  static final User _singleton = User._internal();

  factory User() {
    return _singleton;
  }

  User._internal();

  factory User.fromJson(Map<String, dynamic> json) {
    User().id = json["id"] != null ? json["id"].toString() : '';
    User().name = json["name"] != null ? json["name"].toString() : '';
    User().email = json["email"].toString();
    User().phone = json["phone"].toString();
    User().image = json["image"].toString();
    User().roleId = json["role_id"];
    User().status = json["status"];
    return User();
  }
}
