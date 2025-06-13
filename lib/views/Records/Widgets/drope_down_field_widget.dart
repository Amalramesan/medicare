import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String? selectedOption;
  final Function(String?) onChanged;

  DropdownField({
    super.key,
    required this.selectedOption,
    required this.onChanged,
    required Map<String, String> reportTypeOptions,
  });

  final Map<String, String> reportTypeOptions = {
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
      value: selectedOption,
      hint: const Text("Select a Record"),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
      items: reportTypeOptions.keys
          .map((label) => DropdownMenuItem(value: label, child: Text(label)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
