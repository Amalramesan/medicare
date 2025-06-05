import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerButton extends StatefulWidget {
  final void Function(PlatformFile?) onFilePicked;

  const FilePickerButton({super.key, required this.onFilePicked});

  @override
  State<FilePickerButton> createState() => _FilePickerButtonState();
}

class _FilePickerButtonState extends State<FilePickerButton> {
  PlatformFile? _selectedFile;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
      widget.onFilePicked(_selectedFile); // Send file to parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pickFile,
      child: Text(
        _selectedFile == null
            ? "Choose File"
            : "Selected: ${_selectedFile!.name}",
      ),
    );
  }
}
