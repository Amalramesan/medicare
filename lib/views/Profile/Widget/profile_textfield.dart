import 'package:flutter/material.dart';

Widget Textfieldprofile({
  required TextEditingController controller,
  required IconData icon,
  required String label,
  required double width,
  bool readOnly = false,
  TextInputType inputType = TextInputType.text,
}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly,
    keyboardType: inputType,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
