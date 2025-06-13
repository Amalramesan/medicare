class AppointmentBookingHistory {
  AppointmentBookingHistory({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.date,
    required this.time,
    required this.doctorName,
    required this.patientName,
    required this.speciality,
    required this.doctorImage,
  });

  final int id;
  final int patient;
  final int doctor;
  final DateTime date;
  final String time;
  final String doctorName;
  final String patientName;
  final String speciality;
  final String doctorImage;

  factory AppointmentBookingHistory.fromJson(Map<String, dynamic> json) {
    return AppointmentBookingHistory(
      id: json['id'],
      patient: json['patient'],
      doctor: json['doctor'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      doctorName: json['doctor_name'],
      patientName: json['patient_name'],
      speciality: json['speciality'] ?? 'General',
      doctorImage: json['doctor_image'] ?? 'assets/images/default_doc.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient': patient,
      'doctor': doctor,
      'date': date.toIso8601String(),
      'time': time,
      'doctor_name': doctorName,
      'patient_name': patientName,
      'speciality': speciality,
      'doctor_image': doctorImage,
    };
  }
}
