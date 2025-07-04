import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String? selectedOption; // This must be the backend value like "MRI"
  final Function(String?) onChanged;

  const DropdownField({
    super.key,
    required this.selectedOption,
    required this.onChanged,
    required Map<String, String> reportTypeOptions,
  });

  static const Map<String, String> reportTypeOptions = {
    'Blood Test': 'BLOOD',
    'X-Ray': 'XRAY',
    'MRI Scan': 'MRI',
    'CT Scan': 'CT',
    'Urine Test': 'URINE',
    'Other': 'OTHER',
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedOption, // must be backend value like 'MRI'
      hint: const Text("Select a Record"),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
      items: reportTypeOptions.entries
          .map(
            (entry) => DropdownMenuItem(
              value: entry.value, // 'MRI'
              child: Text(entry.key), // 'MRI Scan'
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
