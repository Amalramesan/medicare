class RegisterModel {
  RegisterModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });
  late final String status;
  late final int statusCode;
  late final String message;
  late final User data;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = User.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final dataa = <String, dynamic>{};
    dataa['status'] = status;
    dataa['status_code'] = statusCode;
    dataa['message'] = message;
    dataa['data'] = data.toJson();
    return dataa;
  }
}

class User {
  User({
    required this.name,
    required this.email,
    required this.age,
    required this.place,
    required this.gender,
    required this.phoneNumber,
    required this.password,
    required this.confirm_password,
  });
  late final String name;
  late final String email;
  late final int age;
  late final String place;
  late final String gender;
  late final String phoneNumber;
  late final String password;
  late final String confirm_password;

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    age = json['age'];
    place = json['place'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['age'] = age;
    data['place'] = place;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    data['password'] = password;
    data['confirm_password'] = confirm_password;
    return data;
  }
}
