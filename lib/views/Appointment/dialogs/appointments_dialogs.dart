import 'package:flutter/material.dart';
import 'dialog_date.dart';
import 'dialog_doctor.dart';
import 'dialog_timeslot.dart';

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
                SelectDoctorStep(
                  onDoctorSelected: (doctorName) =>
                      setState(() => selectedDoctor = doctorName),
                  onContinue: _nextStep,
                  onBack: _previousStep,
                )
              else if (_currentStep == 2 &&
                  selectedDoctor != null &&
                  selectedDate != null)
                SelectTimeStep(
                  selectedDoctor: selectedDoctor!,
                  selectedDate: selectedDate!,
                  onBack: _previousStep,
                  onConfirm: (time) {
                    setState(() => selectedTime = time);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Appointment Confirmed'),
                        content: Text(
                          'Your appointment with $selectedDoctor on ${selectedDate!.toLocal().toString().split(" ")[0]} at $time is confirmed.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Done'),
                          ),
                        ],
                      ),
                    );
                  },
                )
              else
                const Padding(
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
