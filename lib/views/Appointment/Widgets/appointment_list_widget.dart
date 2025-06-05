import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/Widgets/list_appointments_widget.dart';

class AppointmentsListWidget extends StatelessWidget {
  final List<Map<String, String>> appointments;

  const AppointmentsListWidget({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: appointments.map((appointment) {
        return AppointmentList(
          imagepath: appointment["imagePath"]!,
          doctorName: appointment["doctorName"]!,
          speciality: appointment["specialty"]!,
          date: appointment["date"]!,
          time: appointment["time"]!,
        );
      }).toList(),
    );
  }
}
