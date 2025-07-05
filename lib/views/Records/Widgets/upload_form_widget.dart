import 'package:flutter/material.dart';
import 'package:med_care/data/response/status.dart';
import 'package:provider/provider.dart';
import 'package:med_care/view_model/controller/upload_controller.dart';
import 'package:med_care/views/records/Widgets/description_record_field.dart';
import 'package:med_care/views/records/Widgets/drope_down_field_widget.dart';
import 'package:med_care/views/records/Widgets/file_picker_buttton.dart';
import 'package:med_care/views/records/Widgets/dialog_button_widget.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({super.key});

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final TextEditingController descriptionController = TextEditingController();


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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select report type and file.")),
    );
    return;
  }

  await controller.uploadFile(description: descriptionController.text.trim());

  final response = controller.uploadResponse;

  if (!mounted) return;

  if (response.status == Status.completed) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.data ?? "Upload completed")),
    );
  } else if (response.status == Status.error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.message ?? "Something went wrong")),
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
        controller.uploadResponse.status == Status.loading//loading
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CircularProgressIndicator(),
              )
            : DialogButtons(
                onClose: () => Navigator.pop(context),
                onSubmit: () => handleSubmit(controller),
              ),
      ],
    );
  }
}
