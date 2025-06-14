// import 'package:flutter/material.dart';
// import 'package:med_care/Models/appointment_history_model.dart';
// import 'package:med_care/services/api_services.dart';
// import 'package:med_care/views/Appointment/Widgets/appointent_card.dart';

// class AppointmentHistoryPage extends StatelessWidget {
//   final int patientId;

//   const AppointmentHistoryPage({super.key, required this.patientId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<AppointmentHistoryModel>>(
//         future: ApiServices().(patientId),

//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("No appointment history found."));
//           } else {
//             final appointments = snapshot.data!;
//             return ListView.builder(
//               itemCount: appointments.length,
//               itemBuilder: (context, index) {
//                 return AppointmentList(appointment: appointments[index]);
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
