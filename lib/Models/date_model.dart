class DateModel {
  DateModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });
  late final String status;
  late final int statusCode;
  late final String message;
  late final List<Datedata> data;

  DateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Datedata.fromJson(e)).toList();
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

class Datedata {
  Datedata({
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.repeatDays,
  });
  late final String startTime;
  late final String endTime;
  late final String repeat;
  late final List<dynamic> repeatDays;

  Datedata.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    repeat = json['repeat'];
    repeatDays = List.castFrom<dynamic, dynamic>(json['repeat_days']);
  }

  Map<String, dynamic> toJson() {
    final datas = <String, dynamic>{};
    datas['start_time'] = startTime;
    datas['end_time'] = endTime;
    datas['repeat'] = repeat;
    datas['repeat_days'] = repeatDays;
    return datas;
  }
}
