class ProfileModel {
  ProfileModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });
  late final String status;
  late final int statusCode;
  late final String message;
  late final Data data;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = Data.fromJson(json['data']);
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

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.place,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String phoneNumber;
  late final int age;
  late final String place;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    age = json['age'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final datass = <String, dynamic>{};
    datass['id'] = id;
    datass['name'] = name;
    datass['email'] = email;
    datass['phone_number'] = phoneNumber;
    datass['age'] = age;
    datass['place'] = place;
    return datass;
  }
}
