import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:med_care/View_model/controller/report_fetch_controller.dart';
import 'package:provider/provider.dart';
import 'package:med_care/View_model/controller/upload_controller.dart';

import 'package:med_care/views/records/Widgets/description_record_field.dart';
import 'package:med_care/views/records/Widgets/dialog_button_widget.dart';
import 'package:med_care/views/records/Widgets/drope_down_field_widget.dart';
import 'package:med_care/views/records/Widgets/file_picker_buttton.dart';
import 'package:med_care/data/response/status.dart';

class DropedownnBodyState extends StatefulWidget {
  const DropedownnBodyState({super.key});

  @override
  _DropedownnBodyState createState() => _DropedownnBodyState();
}

class _DropedownnBodyState extends State<DropedownnBodyState> {
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
    final status = controller.uploadResponse.status;

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

            DropdownField(
              selectedOption: controller.selectedReportType,
              onChanged: controller.setReportType,
              reportTypeOptions: reportTypeOptions,
            ),

            const SizedBox(height: 20),

            DescriptionField(controller: descriptionCtrl),
            const SizedBox(height: 16),

            FilePickerButton(onFilePicked: controller.setPickedFile),
            const SizedBox(height: 24),

            if (status == Status.loading)
              const CircularProgressIndicator()
            else
              DialogButtons(
                onClose: () => Navigator.pop(context),
                onSubmit: () async {
                  if (controller.selectedReportType == null ||
                      controller.pickedFile == null) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select report type and file."),
                        ),
                      );
                    }
                    return;
                  }

                  await controller.uploadFile(
                    description: descriptionCtrl.text.trim(),
                  );

                  if (!context.mounted) return;

                  if (controller.uploadResponse.status == Status.completed) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          controller.uploadResponse.data ??
                              "Upload successful!",
                        ),
                      ),
                    );

                    // ✅ Refresh reports
                    final reportController = context
                        .read<ReportFetchController>();
                    reportController.fetchReports();
                  } else if (controller.uploadResponse.status == Status.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          controller.uploadResponse.message ?? "Upload failed",
                        ),
                      ),
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
