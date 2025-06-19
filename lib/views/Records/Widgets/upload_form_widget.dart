import 'dart:io';
import 'package:flutter/material.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/controller/upload_controller.dart';
import 'package:med_care/views/Records/Widgets/description_record_field.dart';
import 'package:med_care/views/Records/Widgets/drope_down_field_widget.dart';
import 'package:med_care/views/Records/Widgets/file_picker_buttton.dart';
import 'package:med_care/views/Records/Widgets/dialog_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class UploadForm extends StatelessWidget {
  const UploadForm({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadProvider = Provider.of<UploadController>(context, listen: true);
    final TextEditingController _descriptionController =
        TextEditingController();

    final Map<String, String> reportTypeOptions = {
      'Blood Test': 'BLOOD',
      'X-Ray': 'XRAY',
      'MRI Scan': 'MRI',
      'CT Scan': 'CT',
      'Urine Test': 'URINE',
      'Other': 'OTHER',
    };

    Future<void> _handleSubmit() async {
      if (uploadProvider.selectedReportType == null ||
          uploadProvider.pickedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select report type and file.")),
        );
        return;
      }

      uploadProvider.setLoading(true);

      final prefs = await SharedPreferences.getInstance();
      final patientId = prefs.getInt('patient_id');

      if (patientId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Patient ID not found")));
        uploadProvider.setLoading(false);
        return;
      }

      if (uploadProvider.pickedFile?.path == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid file selected.")));
        uploadProvider.setLoading(false);
        return;
      }

      final file = File(uploadProvider.pickedFile!.path!);

      final response = await ApiServices.uploadDocuments(
        documentFile: file,
        report: reportTypeOptions[uploadProvider.selectedReportType]!,
        description: _descriptionController.text,
        patientId: patientId,
      );

      uploadProvider.setLoading(false);

      if (response != null) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload successful: ${response.message}")),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Upload failed")));
      }
    }

    return AlertDialog(
      title: const Text("Upload Medical Record"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownField(
              selectedOption: uploadProvider.selectedReportType,
              onChanged: (value) => uploadProvider.setReportType(value),
              reportTypeOptions: reportTypeOptions,
            ),
            const SizedBox(height: 12),
            DescriptionField(controller: _descriptionController),
            const SizedBox(height: 12),
            FilePickerButton(
              onFilePicked: (file) => uploadProvider.setPickedFile(file),
            ),
          ],
        ),
      ),
      actions: [
        uploadProvider.isLoading
            ? const CircularProgressIndicator()
            : DialogButtons(
                onClose: () => Navigator.pop(context),
                onSubmit: _handleSubmit,
              ),
      ],
    );
  }
}
