import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/controller/upload_controller.dart';
import 'package:med_care/views/Records/Widgets/description_record_field.dart';
import 'package:med_care/views/Records/Widgets/dialog_button_widget.dart';
import 'package:med_care/views/Records/Widgets/drope_down_field_widget.dart';
import 'package:med_care/views/Records/Widgets/file_picker_buttton.dart';

class Dropedownn extends StatelessWidget {
  const Dropedownn({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DropedownnBody();
  }
}

class _DropedownnBody extends StatefulWidget {
  const _DropedownnBody();

  @override
  State<_DropedownnBody> createState() => _DropedownnBodyState();
}

class _DropedownnBodyState extends State<_DropedownnBody> {
  final TextEditingController descriptionCtrl = TextEditingController();
  final Logger logger = Logger();

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
    final controller = Provider.of<UploadController>(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "RECORDS",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// Dropdown
            DropdownField(
              selectedOption: controller.selectedReportType,
              onChanged: controller.setReportType,
              reportTypeOptions: reportTypeOptions,
            ),
            const SizedBox(height: 20),

            /// Description
            DescriptionField(controller: descriptionCtrl),
            const SizedBox(height: 16),

            /// File Picker
            FilePickerButton(onFilePicked: controller.setPickedFile),
            const SizedBox(height: 24),

            /// Buttons
            controller.isLoading
                ? const CircularProgressIndicator()
                : DialogButtons(
                    onClose: () => Navigator.pop(context),
                    onSubmit: () async {
                      if (controller.selectedReportType == null ||
                          controller.pickedFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please select report type and file.",
                            ),
                          ),
                        );
                        return;
                      }

                      controller.setLoading(true);

                      try {
                        final prefs = await SharedPreferences.getInstance();
                        final patientId = prefs.getInt('patient_id');

                        if (patientId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Patient ID not found."),
                            ),
                          );
                          controller.setLoading(false);
                          return;
                        }

                        final file = File(controller.pickedFile!.path!);
                        final response = await ApiServices.uploadDocuments(
                          documentFile: file,
                          report:
                              reportTypeOptions[controller.selectedReportType]!,
                          description: descriptionCtrl.text,
                          patientId: patientId,
                        );

                        if (!mounted) return;

                        controller.setLoading(false);

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
                        logger.e("Upload failed", error: e);
                        controller.setLoading(false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Something went wrong: $e")),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
