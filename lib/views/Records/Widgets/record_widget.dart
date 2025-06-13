import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/views/Records/Widgets/description_record_field.dart';
import 'package:med_care/views/Records/Widgets/dialog_button_widget.dart';
import 'package:med_care/views/Records/Widgets/drope_down_field_widget.dart';
import 'package:med_care/views/Records/Widgets/file_picker_buttton.dart';

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

  // ✅ Define report type map
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

              /// Dropdown
              DropdownField(
                selectedOption: selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue;
                  });
                },
                reportTypeOptions: reportTypeOptions,
              ),

              const SizedBox(height: 20),

              /// Description field
              DescriptionField(controller: descriptionctrl),

              const SizedBox(height: 16),

              /// File Picker
              FilePickerButton(
                onFilePicked: (file) {
                  setState(() {
                    selectedfile = file;
                  });
                },
              ),

              const SizedBox(height: 24),

              /// Buttons
              DialogButtons(
                onClose: () => Navigator.pop(context),
                onSubmit: () async {
                  try {
                    if (selectedOption == null || selectedfile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select report type and file."),
                        ),
                      );
                      return;
                    }

                    final prefs = await SharedPreferences.getInstance();
                    final patientId = prefs.getInt('patient_id');

                    if (patientId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Patient ID not found.")),
                      );
                      return;
                    }

                    final file = File(selectedfile!.path!);

                    final response = await ApiServices.uploadDocuments(
                      documentFile: file,
                      report:
                          reportTypeOptions[selectedOption]!, // ✅ use backend code
                      description: descriptionctrl.text,
                      patientId: patientId,
                    );

                    if (!mounted) return;

                    if (response != null) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Upload successful: ${response.message}",
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Upload failed.")),
                      );
                    }
                  } catch (e) {
                    logger.e("Error during upload", error: e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something went wrong: $e")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
