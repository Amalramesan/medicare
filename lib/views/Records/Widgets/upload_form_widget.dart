import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:med_care/Resporitary/documents.dart' as ApiServices;
import 'package:med_care/View_model/controller/upload_controller.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';
import 'package:med_care/views/Records/Widgets/description_record_field.dart';
import 'package:med_care/views/Records/Widgets/drope_down_field_widget.dart';
import 'package:med_care/views/Records/Widgets/file_picker_buttton.dart';
import 'package:med_care/views/Records/Widgets/dialog_button_widget.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({super.key});

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final TextEditingController descriptionController = TextEditingController();
  final LocalStorageService _storage = LocalStorageService();

  final Map<String, String> reportTypeOptions = {
    'Blood Test': 'BLOOD',
    'X-Ray': 'XRAY',
    'MRI Scan': 'MRI',
    'CT Scan': 'CT',
    'Urine Test': 'URINE',
    'Other': 'OTHER',
  };

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> handleSubmit(UploadController controller) async {
    if (controller.selectedReportType == null || controller.pickedFile == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select report type and file.")),
      );
      return;
    }

    final token = _storage.accessToken;
    final patientId = _storage.patientId;

    if (token == null || patientId == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Patient ID or token not found.")),
      );
      return;
    }

    if (controller.pickedFile?.path == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid file selected.")),
      );
      return;
    }

    controller.setLoading(true);

    try {
      final file = File(controller.pickedFile!.path!);
      final documentRepo = ApiServices.DocumentRepository();

      final response = await documentRepo.uploadDocument(
        documentFile: file,
        report: reportTypeOptions[controller.selectedReportType]!,
        description: descriptionController.text,
        patientId: patientId,
        token: token,
      );

      controller.setLoading(false);

      if (!mounted) return;

      if (response != null) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Upload successful: ${response.message}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Upload failed")),
        );
      }
    } catch (e) {
      controller.setLoading(false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UploadController>(context);

    return AlertDialog(
      title: const Text("Upload Medical Record"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownField(
              selectedOption: controller.selectedReportType,
              onChanged: controller.setReportType,
              reportTypeOptions: reportTypeOptions,
            ),
            const SizedBox(height: 12),
            DescriptionField(controller: descriptionController),
            const SizedBox(height: 12),
            FilePickerButton(onFilePicked: controller.setPickedFile),
          ],
        ),
      ),
      actions: [
        controller.isLoading
            ? const CircularProgressIndicator()
            : DialogButtons(
                onClose: () => Navigator.pop(context),
                onSubmit: () => handleSubmit(controller),
              ),
      ],
    );
  }
}
