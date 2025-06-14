import 'package:flutter/material.dart';
import 'package:med_care/Models/appointment_history_model.dart';

class AppointmentList extends StatelessWidget {
  final AppointmentHistoryModel appointment;

  const AppointmentList({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor name
          Text(
            appointment.doctorName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          // Patient name
          Text(
            "Patient: ${appointment.patientName}",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 6),

          // Date & Time
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(appointment.date, style: const TextStyle(fontSize: 13)),
              const SizedBox(width: 12),
              const Icon(Icons.access_time, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(appointment.time, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}
