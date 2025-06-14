import 'package:flutter/material.dart';
import 'package:med_care/Models/appointment_history_model.dart';
import 'package:med_care/services/api_services.dart';
import 'package:med_care/views/Appointment/Widgets/appointent_card.dart';
import 'package:med_care/views/Appointment/Widgets/book_appointment_button_widget.dart';
import 'package:med_care/views/Appointment/Widgets/greeting_widget.dart';
import 'package:med_care/views/Appointment/Widgets/upcomming_appointment_title_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Future<List<AppointmentHistoryModel>>? _appointments;

  @override
  void initState() {
    super.initState();
    _loadAppointments(); // async method
  }

  Future<void> _loadAppointments() async {
    int? patientId = await getPatientId();
    if (patientId != null) {
      setState(() {
        _appointments = ApiServices.fetchPatientAppointments(patientId);
      });
    } else {
      // fallback if patient ID not found
      setState(() {
        _appointments = Future.value([]);
      });
    }
  }

  Future<int?> getPatientId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('patient_id');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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

          // FutureBuilder only if _appointments is not null
          if (_appointments != null)
            FutureBuilder<List<AppointmentHistoryModel>>(
              future: _appointments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No appointments found."));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return AppointmentList(
                        appointment: snapshot.data![index],
                      );
                    },
                  );
                }
              },
            )
          else
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
