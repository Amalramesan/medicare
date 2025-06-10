class LoginModel {
  LoginModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });
  late final String status;
  late final int statusCode;
  late final String message;
  late final Token data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = Token.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final datas = <String, dynamic>{};
    datas['status'] = status;
    datas['status_code'] = statusCode;
    datas['message'] = message;
    datas['data'] = data.toJson();
    return datas;
  }
}

class Token {
  Token({required this.refresh, required this.access, required this.user});
  late final String refresh;
  late final String access;
  late final LoginUser user;

  Token.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    user = LoginUser.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final tokendata = <String, dynamic>{};
    tokendata['refresh'] = refresh;
    tokendata['access'] = access;
    tokendata['user'] = user.toJson();
    return tokendata;
  }
}

class LoginUser {
  LoginUser({required this.id, required this.email});
  late final int id;
  late final String email;

  LoginUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final userdata = <String, dynamic>{};
    userdata['id'] = id;
    userdata['email'] = email;
    return userdata;
  }
}
