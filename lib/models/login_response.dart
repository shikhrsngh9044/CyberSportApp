class LoginResponse {
  final String token;
  final String message;
  LoginData data;

  LoginResponse({this.message, this.token, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        message: json['message'],
        token: json['token'],
        data: LoginData.fromJson(json['data']));
  }

/*Map toMap() {
    var map = new Map<String, dynamic>();
    map["message"] = message;
    map["token"] = token;
    return map;
  }*/
}

class LoginData {
  final String id;

  LoginData({this.id});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(id: json["_id"]);
  }
}
