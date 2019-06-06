class Register {
  final String name;
  final String email;
  final String username;
  final String password;
  final String contact;
  final String message;
  RegisterData data;

  Register(
      {this.name,
      this.email,
      this.contact,
      this.username,
      this.password,
      this.message,
      this.data});

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
        message: json['message'], data: RegisterData.fromJson(json['data']));
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["email"] = email;
    map["user_name"] = username;
    map["password"] = password;
    map["contact"] = contact;
    return map;
  }
}

class RegisterData {
  final String id;
  final String email;

  RegisterData({this.id, this.email});

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(id: json["_id"], email: json["email"]);
  }
}
