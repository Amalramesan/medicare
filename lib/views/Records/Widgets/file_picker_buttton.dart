import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:med_care/controller/upload_controller.dart'; // <-- import your controller
import 'package:provider/provider.dart';

class FilePickerButton extends StatelessWidget {
  final void Function(PlatformFile?) onFilePicked;

  const FilePickerButton({super.key, required this.onFilePicked});

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = result.files.first;

      // Update controller
      if(context.mounted){
        Provider.of<UploadController>(context, listen: false).setPickedFile(file);
      }

      // Send file to parent if needed
      onFilePicked(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickedFile = context.watch<UploadController>().pickedFile;

    return ElevatedButton(
      onPressed: () => pickFile(context),
      child: Text(
        pickedFile == null ? "Choose File" : "Selected: ${pickedFile.name}",
      ),
    );
  }
}
