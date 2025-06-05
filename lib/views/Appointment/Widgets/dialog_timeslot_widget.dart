import 'package:flutter/material.dart';

class SelectTimeStep extends StatefulWidget {
  final VoidCallback onBack;
  final ValueChanged<String> onConfirm;
  final String selectedDoctor;
  final DateTime selectedDate;

  const SelectTimeStep({
    super.key,
    required this.onBack,
    required this.onConfirm,
    required this.selectedDoctor,
    required this.selectedDate,
  });

  @override
  State<SelectTimeStep> createState() => _SelectTimeStepState();
}

class _SelectTimeStepState extends State<SelectTimeStep> {
  String? selectedTime;

  final Map<String, bool> timeSlots = {
    '9:00 AM': true,
    '10:00 AM': true,
    '11:00 AM': false,
    '1:00 PM': true,
    '2:00 PM': true,
    '3:00 PM': false,
    '4:00 PM': true,
    '5:00 PM': true,
  };

  @override
  Widget build(BuildContext context) {
    final formattedDate = widget.selectedDate.toLocal().toString().split(
      ' ',
    )[0];

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
          children: timeSlots.entries.map((entry) {
            final time = entry.key;
            final isAvailable = entry.value;
            final isSelected = selectedTime == time;

            return GestureDetector(
              onTap: isAvailable
                  ? () => setState(() {
                      selectedTime = time;
                    })
                  : null,
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
                        style: TextStyle(
                          color: isAvailable ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        isAvailable ? 'Available' : 'Booked',
                        style: TextStyle(
                          color: isAvailable ? Colors.green : Colors.grey,
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
            OutlinedButton(onPressed: widget.onBack, child: const Text("Back")),
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
  }
}
