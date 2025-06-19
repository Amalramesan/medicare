import 'package:flutter/material.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/controller/appointment_booking_controller.dart';
import 'package:med_care/controller/apoointment_history_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dialog_date_widget.dart';
import 'dialog_doctor_widget.dart';
import 'dialog_timeslot_widget.dart';

class AppointmentDialog extends StatelessWidget {
  const AppointmentDialog({super.key});

  Widget _buildTab(String title, int index, int currentStep) {
    final isActive = currentStep == index;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AppointmentBookingController>(context);
    final currentStep = controller.currentStep;
    final selectedDate = controller.selectedDate;
    final selectedDoctor = controller.selectedDoctor;
    final selectedDoctorId = controller.selectedDoctorId;

    final screenHeight = MediaQuery.of(context).size.height;
    final dialogHeight = screenHeight * 0.85;

    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxHeight: dialogHeight),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Book Appointment",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _buildTab("Select Date", 0, currentStep),
                    _buildTab("Select Doctor", 1, currentStep),
                    _buildTab("Select Time", 2, currentStep),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              if (currentStep == 0)
                SelectDateStep(
                  selectedDate: selectedDate,
                  onDateSelected: (date) => controller.selectDate(date),
                  onContinue: controller.nextStep,
                )
              else if (currentStep == 1)
                selectedDate != null
                    ? SelectDoctorStep(
                        selectedDate: selectedDate,
                        onDoctorSelected: (doctor) => controller.selectDoctor(
                          name: doctor.name,
                          id: doctor.id.toString(),
                        ),
                        onContinue: controller.nextStep,
                        onBack: controller.previousStep,
                      )
                    : const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text("Please select a date first"),
                        ),
                      )
              else if (currentStep == 2)
                (selectedDoctor != null &&
                        selectedDate != null &&
                        selectedDoctorId != null)
                    ? SelectTimeStep(
                        selectedDoctor: selectedDoctor,
                        selectedDate: selectedDate,
                        selectedDoctorId: selectedDoctorId,
                        onBack: controller.previousStep,
                        onConfirm: (String time) async {
                          controller.selectTime(time);

                          try {
                            final prefs = await SharedPreferences.getInstance();
                            final patientId = prefs.getInt('patient_id');

                            if (patientId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Patient ID not found. Please log in again.",
                                  ),
                                ),
                              );
                              return;
                            }

                            final response = await ApiServices()
                                .saveAppointment(
                                  doctorId: int.parse(selectedDoctorId),
                                  patientId: patientId,
                                  date: selectedDate.toIso8601String().split(
                                    "T",
                                  )[0],
                                  time: time,
                                );

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Appointment Confirmed'),
                                content: Text(
                                  'Your appointment with ${response.data.doctorName} on ${response.data.date} at ${response.data.time} is confirmed.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<AppointmentController>(
                                        context,
                                        listen: false,
                                      ).fetchAppointments();
                                      controller.reset();

                                      Navigator.of(
                                        context,
                                      ).pop(); // close alert
                                      Navigator.of(
                                        context,
                                      ).pop(); // close dialog
                                    },
                                    child: const Text('Done'),
                                  ),
                                ],
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Booking failed: $e")),
                            );
                          }
                        },
                      )
                    : const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text("Please select a date and doctor first"),
                        ),
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
