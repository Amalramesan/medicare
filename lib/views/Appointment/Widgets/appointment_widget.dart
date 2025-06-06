import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/Widgets/appointment_data.dart';
import 'package:med_care/views/Appointment/Widgets/appointment_list_widget.dart';
import 'package:med_care/views/Appointment/Widgets/book_appointment_button_widget.dart';
import 'package:med_care/views/Appointment/Widgets/greeting_widget.dart';
import 'package:med_care/views/Appointment/Widgets/upcomming_appointment_title_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final appointments = sampleAppointments;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Greeting
          GreetingWidget(screenWidth: screenWidth, screenHeight: screenHeight),

          SizedBox(height: screenHeight * 0.03),

          // Appointment button
          BookAppointmentButton(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),

          SizedBox(height: screenHeight * 0.02),

          // Upcoming Appointments title
          AppointmentsTitleWidget(screenWidth: screenWidth),

          // List of Appointments
          AppointmentsListWidget(appointments: sampleAppointments),
        ],
      ),
    );
  }
}
