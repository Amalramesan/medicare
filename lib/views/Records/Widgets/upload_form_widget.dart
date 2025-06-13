import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/views/Records/Widgets/description_record_field.dart';
import 'package:med_care/views/Records/Widgets/drope_down_field_widget.dart';
import 'package:med_care/views/Records/Widgets/file_picker_buttton.dart';
import 'package:med_care/views/Records/Widgets/dialog_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({super.key});

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  String? selectedReportType;
  final TextEditingController _descriptionController = TextEditingController();
  PlatformFile? _pickedFile;
  bool isLoading = false;

  final Map<String, String> reportTypeOptions = {
    'Blood Test': 'BLOOD',
    'X-Ray': 'XRAY',
    'MRI Scan': 'MRI',
    'CT Scan': 'CT',
    'Urine Test': 'URINE',
    'Other': 'OTHER',
  };

  void _onFilePicked(PlatformFile? file) {
    setState(() => _pickedFile = file);
  }

  Future<void> _handleSubmit() async {
    if (selectedReportType == null || _pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select report type and file.")),
      );
      return;
    }

    setState(() => isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    final patientId = prefs.getInt('patient_id');

    if (patientId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Patient ID not found")));
      if (!mounted) return;
      setState(() => isLoading = false);
      return;
    }

    if (_pickedFile?.path == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid file selected.")));
      setState(() => isLoading = false);
      return;
    }

    final file = File(_pickedFile!.path!);

    final response = await ApiServices.uploadDocuments(
      documentFile: file,
      report: reportTypeOptions[selectedReportType]!, // use mapped value here
      description: _descriptionController.text,
      patientId: patientId,
    );

    setState(() => isLoading = false);

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Upload Medical Record"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownField(
              selectedOption: selectedReportType,
              onChanged: (value) => setState(() => selectedReportType = value),
              reportTypeOptions: reportTypeOptions,
            ),
            const SizedBox(height: 12),
            DescriptionField(controller: _descriptionController),
            const SizedBox(height: 12),
            FilePickerButton(onFilePicked: _onFilePicked),
          ],
        ),
      ),
      actions: [
        isLoading
            ? const CircularProgressIndicator()
            : DialogButtons(
                onClose: () => Navigator.pop(context),
                onSubmit: _handleSubmit,
              ),
      ],
    );
  }
}
