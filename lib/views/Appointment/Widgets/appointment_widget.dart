import 'package:flutter/material.dart';
import 'package:med_care/controller/apoointment_history_controller.dart';
import 'package:med_care/views/Appointment/Widgets/appointent_card.dart';
import 'package:med_care/views/Appointment/Widgets/book_appointment_button_widget.dart';
import 'package:med_care/views/Appointment/Widgets/greeting_widget.dart';
import 'package:med_care/views/Appointment/Widgets/upcomming_appointment_title_widget.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (mounted) {
      Provider.of<AppointmentController>(
        context,
        listen: false,
      ).fetchAppointments();
    }
  });
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final appointmentProvider = Provider.of<AppointmentController>(context);
    final isLoading = appointmentProvider.isLoading;
    final error = appointmentProvider.error;
    final appointments = appointmentProvider.appointments;

    return SingleChildScrollView(
      child: Column(
        children: [
          GreetingWidget(screenWidth: screenWidth, screenHeight: screenHeight),
          SizedBox(height: screenHeight * 0.03),
          BookAppointmentButton(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          AppointmentsTitleWidget(screenWidth: screenWidth),

          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (error != null)
            Center(child: Text('Error: $error'))
          else if (appointments.isEmpty)
            const Center(child: Text("No appointments found."))
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                return AppointmentList(
                  appointment: appointments[index],
                  onCancel: () async {
                    await appointmentProvider.cancelAppointmentById(
                      appointments[index].id.toString(),
                    );

                    if (appointmentProvider.error == null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Appointment cancelled'),
                          ),
                        );
                      }
                      // Refresh the list
                      appointmentProvider.fetchAppointments();
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(appointmentProvider.error!)),
                        );
                      }
                    }
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
