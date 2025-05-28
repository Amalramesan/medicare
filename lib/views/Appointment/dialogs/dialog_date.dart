import 'package:flutter/material.dart';

class SelectDateStep extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onContinue;

  const SelectDateStep({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choose a Date",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        CalendarDatePicker(
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateChanged: onDateSelected,
        ),

        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: onContinue,
            child: const Text("Continue"),
          ),
        ),
      ],
    );
  }
}
