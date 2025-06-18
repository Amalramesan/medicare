// // appointment_history_screen.dart

// import 'package:flutter/material.dart';
// import 'package:med_care/controller/apoointment_history_controller.dart';
// import 'package:med_care/views/Appointment/Widgets/appointent_card.dart';
// import 'package:provider/provider.dart';

// class AppointmentHistoryScreen extends StatelessWidget {
//   const AppointmentHistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Appointments")),
//       body: Consumer<AppointmentController>(
//         builder: (context, controller, _) {
//           if (controller.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (controller.appointments.isEmpty) {
//             return const Center(child: Text('No Appointments'));
//           }

//           return ListView.builder(
//             itemCount: controller.appointments.length,
//             itemBuilder: (context, index) {
//               final appt = controller.appointments[index];
//               return AppointmentList(
//                 appointment: appt,
//                 onCancel: () async {
//                   await controller.cancelAppointmentById(appt.id.toString());

//                   if (controller.error == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Appointment cancelled')),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(
//                       context,
//                     ).showSnackBar(SnackBar(content: Text(controller.error!)));
//                   }
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
