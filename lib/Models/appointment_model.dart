class AppointmentBooking {
  AppointmentBooking({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });
  late final String status;
  late final int statusCode;
  late final String message;
  late final Data data;

  AppointmentBooking.fromJson(Map<String, dynamic> json) {
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
    required this.patient,
    required this.doctor,
    required this.date,
    required this.time,
    required this.doctorName,
    required this.patientName,
  });
  late final int id;
  late final int patient;
  late final int doctor;
  late final String date;
  late final String time;
  late final String doctorName;
  late final String patientName;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient = json['patient'];
    doctor = json['doctor'];
    date = json['date'];
    time = json['time'];
    doctorName = json['doctor_name'];
    patientName = json['patient_name'];
  }

  Map<String, dynamic> toJson() {
    final datass = <String, dynamic>{};
    datass['id'] = id;
    datass['patient'] = patient;
    datass['doctor'] = doctor;
    datass['date'] = date;
    datass['time'] = time;
    datass['doctor_name'] = doctorName;
    datass['patient_name'] = patientName;
    return datass;
  }
}
