class TimeSlots {
  TimeSlots({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });
  late final String status;
  late final int statusCode;
  late final String message;
  late final Data data;

  TimeSlots.fromJson(Map<String, dynamic> json) {
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
  Data({required this.availableSlots});
  late final List<String> availableSlots;

  Data.fromJson(Map<String, dynamic> json) {
    availableSlots = List.castFrom<dynamic, String>(json['available_slots']);
  }

  Map<String, dynamic> toJson() {
    final datass = <String, dynamic>{};
    datass['available_slots'] = availableSlots;
    return datass;
  }
}
