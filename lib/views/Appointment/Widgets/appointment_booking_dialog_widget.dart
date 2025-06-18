import 'package:flutter/material.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/controller/apoointment_history_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dialog_date_widget.dart';
import 'dialog_doctor_widget.dart';
import 'dialog_timeslot_widget.dart';

class AppointmentDialog extends StatefulWidget {
  const AppointmentDialog({super.key});

  @override
  State<AppointmentDialog> createState() => _AppointmentDialogState();
}

class _AppointmentDialogState extends State<AppointmentDialog> {
  int _currentStep = 0;
  DateTime? selectedDate;
  String? selectedDoctor;
  String? selectedTime;
  String? selectedDoctorId;

  void _nextStep() {
    setState(() {
      if (_currentStep < 2) _currentStep++;
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) _currentStep--;
    });
  }

  Widget _buildTab(String title, int index) {
    final isActive = _currentStep == index;
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
                    _buildTab("Select Date", 0),
                    _buildTab("Select Doctor", 1),
                    _buildTab("Select Time", 2),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              if (_currentStep == 0)
                SelectDateStep(
                  selectedDate: selectedDate,
                  onDateSelected: (date) => setState(() => selectedDate = date),
                  onContinue: _nextStep,
                )
              else if (_currentStep == 1)
                selectedDate != null
                    ? SelectDoctorStep(
                        onDoctorSelected: (doctor) {
                          setState(() {
                            selectedDoctor = doctor.name;
                            selectedDoctorId = doctor.id.toString();
                          });
                        },
                        onContinue: _nextStep,
                        onBack: _previousStep,
                        selectedDate: selectedDate!,
                      )
                    : const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text("Please select a date first"),
                        ),
                      )
              else if (_currentStep == 2)
                (selectedDoctor != null &&
                        selectedDate != null &&
                        selectedDoctorId != null)
                    ? SelectTimeStep(
                        selectedDoctor: selectedDoctor!,
                        selectedDate: selectedDate!,
                        selectedDoctorId: selectedDoctorId!,
                        onBack: _previousStep,
                        onConfirm: (String time) async {
                          setState(() => selectedTime = time);

                          try {
                            // Get patient ID from SharedPreferences
                            final prefs = await SharedPreferences.getInstance();
                            final patientId = prefs.getInt(
                              'patient_id',
                            ); // Make sure this is saved earlier

                            if (patientId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Patient ID not found. Please log in again.",
                                  ),
                                ),
                              );
                              return;
                            }

                            // Send data to API
                            final response = await ApiServices()
                                .saveAppointment(
                                  doctorId: int.parse(selectedDoctorId!),
                                  patientId: patientId,
                                  date: selectedDate!.toIso8601String().split(
                                    "T",
                                  )[0],
                                  time: time,
                                );

                            // If successful, show confirmation dialog
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
                                      Navigator.of(
                                        context,
                                      ).pop(); // Close dialog
                                      Navigator.of(
                                        context,
                                      ).pop(); // Close main booking modal
                                    },
                                    child: const Text('Done'),
                                  ),
                                ],
                              ),
                            );
                          } catch (e) {
                            print(e);
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
