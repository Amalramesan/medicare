class LoginModel {
  final String status;
  final int statusCode;
  final String message;
  final Token data;

  LoginModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] ?? '',
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: Token.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'status_code': statusCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Token {
  final String refresh;
  final String access;
  final LoginUser user;

  Token({required this.refresh, required this.access, required this.user});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      refresh: json['refresh'] ?? '',
      access: json['access'] ?? '',
      user: LoginUser.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'refresh': refresh, 'access': access, 'user': user.toJson()};
  }
}

class LoginUser {
  final int id;
  final String email;

  LoginUser({required this.id, required this.email});

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(id: json['id'] ?? 0, email: json['email'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email};
  }
}
