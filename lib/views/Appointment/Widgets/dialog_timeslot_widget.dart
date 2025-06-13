import 'package:flutter/material.dart';
import 'package:med_care/Models/time_slote_model.dart';
import 'package:med_care/Services/api_services.dart';

class SelectTimeStep extends StatefulWidget {
  final VoidCallback onBack;
  final ValueChanged<String> onConfirm;
  final String selectedDoctor;
  final String selectedDoctorId;
  final DateTime selectedDate;

  const SelectTimeStep({
    super.key,
    required this.onBack,
    required this.onConfirm,
    required this.selectedDoctor,
    required this.selectedDate,
    required this.selectedDoctorId,
  });

  @override
  State<SelectTimeStep> createState() => _SelectTimeStepState();
}

class _SelectTimeStepState extends State<SelectTimeStep> {
  String? selectedTime;

  late Future<TimeSlots> timeSlotsFuture;

  @override
  void initState() {
    super.initState();

    // Corrected: use selectedDoctorId
    timeSlotsFuture = ApiServices().fetchTimeSlots(
      widget.selectedDoctorId,
      widget.selectedDate.toIso8601String().split('T')[0],
    );

    // Optional: For debugging
    print(
      'Fetching time slots for doctorId: ${widget.selectedDoctorId}, date: ${widget.selectedDate.toIso8601String().split("T")[0]}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = widget.selectedDate.toLocal().toString().split(
      ' ',
    )[0];

    return FutureBuilder<TimeSlots>(
      future: timeSlotsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final slots = snapshot.data!.data.availableSlots;

          // Safely handle empty slots
          if (slots.isEmpty) {
            return const Center(child: Text('No time slots available.'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose a Time",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Select an available time slot for your appointment with ${widget.selectedDoctor} on $formattedDate",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3,
                children: slots.map((time) {
                  final isSelected = selectedTime == time;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue[50] : Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey[300]!,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              time,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              'Available',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: widget.onBack,
                    child: const Text("Back"),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: selectedTime != null
                        ? () => widget.onConfirm(selectedTime!)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedTime != null
                          ? Colors.blue
                          : Colors.grey,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Confirm Appointment"),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Center(child: Text('No time slots available.'));
        }
      },
    );
  }
}
