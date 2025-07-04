class AvailabilityModel {
  final String status;
  final int statusCode;
  final String message;
  final List<Data> data;

  AvailabilityModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityModel(
      status: json['status'] ?? '',
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'status_code': statusCode,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Data {
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final dynamic repeatDays;

  Data({
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    this.repeatDays,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      repeatDays: json['repeat_days'], // nullable and flexible
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate,
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
      'repeat_days': repeatDays,
    };
  }
}
