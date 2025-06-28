import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_care/View_model/services/validators.dart';
import 'package:med_care/views/Registration/Widgets/spacing_helper_widget.dart';

class GenderAgeRowWidget extends StatelessWidget {
  final TextEditingController ageController;
  final String? genderValue;
  final Function(String?) onGenderChanged;

  GenderAgeRowWidget({
    super.key,
    required this.ageController,
    required this.genderValue,
    required this.onGenderChanged,
  });

  final genderOptions = [
    {'label': 'Male', 'value': 'male'},
    {'label': 'Female', 'value': 'female'},
    {'label': 'Not Prefer to Say', 'value': 'na'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SpacingHelperWidget.fieldpadding(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Age field as you already have...
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                  ),
                  child: SpacingHelperWidget.label("Age"),
                ),
                const SizedBox(height: 5),
                Card(
                  color: Colors.grey[200],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: Validators.validateAge,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.date_range_outlined),
                      hintText: "Age",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Gender dropdown
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpacingHelperWidget.label("Gender"),
                const SizedBox(height: 5),
                Card(
                  color: Colors.grey[200],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonFormField<String>(
                      value: genderValue,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      hint: const Text("Gender"),
                      items: genderOptions.map((option) {
                        return DropdownMenuItem<String>(
                          value: option['value'],
                          child: Text(option['label']!),
                        );
                      }).toList(),
                      onChanged: onGenderChanged,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
