import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:med_care/views/Records/Widgets/description_record_field.dart';
import 'package:med_care/views/Records/Widgets/dialog_button_widget.dart';
import 'package:med_care/views/Records/Widgets/drope_down_field_widget.dart';
import 'package:med_care/views/Records/Widgets/file_picker_buttton.dart';
import 'package:logger/logger.dart';

class Dropedownn extends StatefulWidget {
  const Dropedownn({super.key});

  @override
  State<Dropedownn> createState() => _DropedownnState();
}

class _DropedownnState extends State<Dropedownn> {
  final TextEditingController descriptionctrl = TextEditingController();
  PlatformFile? selectedfile;
  String? selectedOption;
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "RECORDS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              // Dropdown
              DropdownField(
                selectedOption: selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Description field
              DescriptionField(controller: descriptionctrl),

              const SizedBox(height: 16),

              // File Picker
              FilePickerButton(
                onFilePicked: (file) {
                  setState(() {
                    selectedfile = file;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Buttons
              DialogButtons(
                onClose: () {
                  Navigator.pop(context);
                },
                onSubmit: () {
                  logger.i("Selected Option: $selectedOption");
                  logger.i("Description: ${descriptionctrl.text}");
                  logger.i("File: ${selectedfile?.name ?? 'No file selected'}");

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
