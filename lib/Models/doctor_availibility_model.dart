class AvailabilityModel {
  AvailabilityModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });
  late final String status;
  late final int statusCode;
  late final String message;
  late final List<Data> data;

  AvailabilityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final datas = <String, dynamic>{};
    datas['status'] = status;
    datas['status_code'] = statusCode;
    datas['message'] = message;
    datas['data'] = data.map((e) => e.toJson()).toList();
    return datas;
  }
}

class Data {
  Data({
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    this.repeatDays,
  });
  late final String startDate;
  late final String endDate;
  late final String startTime;
  late final String endTime;
  late final Null repeatDays;

  Data.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    repeatDays = null;
  }

  Map<String, dynamic> toJson() {
    final datass = <String, dynamic>{};
    datass['start_date'] = startDate;
    datass['end_date'] = endDate;
    datass['start_time'] = startTime;
    datass['end_time'] = endTime;
    datass['repeat_days'] = repeatDays;
    return datass;
  }
}
