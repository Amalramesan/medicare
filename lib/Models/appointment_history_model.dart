class AppointmentHistoryModel {
  AppointmentHistoryModel({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.date,
    required this.time,
    required this.doctorName,
    required this.patientName,
  });

  final int id;
  final int patient;
  final int doctor;
  final String date;
  final String time;
  final String doctorName;
  final String patientName;

  factory AppointmentHistoryModel.fromJson(Map<String, dynamic> json) {
    return AppointmentHistoryModel(
      id: json['id'],
      patient: json['patient'],
      doctor: json['doctor'],
      date: json['date'],
      time: json['time'],
      doctorName: json['doctor_name'],
      patientName: json['patient_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient': patient,
      'doctor': doctor,
      'date': date,
      'time': time,
      'doctor_name': doctorName,
      'patient_name': patientName,
    };
  }
}
