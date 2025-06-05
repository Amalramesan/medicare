import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String? selectedOption;
  final Function(String?) onChanged;

  const DropdownField({
    super.key,
    required this.selectedOption,
    required this.onChanged,
  });

  final List<String> dropdownItems = const [
    'BLOOD RESULT',
    'URIN TEST',
    'TREATMENT PLANS',
    'DISCHARGE SUMMARY',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedOption,
      hint: const Text("Select a Record"),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
      items: dropdownItems
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
