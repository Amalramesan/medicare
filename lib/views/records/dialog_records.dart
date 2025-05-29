import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Dropedownn extends StatefulWidget {
  const Dropedownn({super.key});

  @override
  State<Dropedownn> createState() => _DropedownnState();
}

class _DropedownnState extends State<Dropedownn> {
  final TextEditingController descriptionctrl = TextEditingController();
  PlatformFile? selectedfile;

  String? selectedOption;
  final List<String> dropdownItems = [
    'BLOOD RESULT',
    'URIN TEST',
    'TREATMENT PLANS',
    'DISCHARGE SUMMARY',
  ];

  // File picker function
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        selectedfile = result.files.first;
      });
    }
  }

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
              DropdownButtonFormField<String>(
                value: selectedOption,
                hint: const Text("Select a Record"),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                items: dropdownItems
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Description field
              TextFormField(
                controller: descriptionctrl,
                decoration: const InputDecoration(
                  labelText: "Enter a description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 16),

              // File Picker
              ElevatedButton(
                onPressed: pickFile,
                child: Text(
                  selectedfile == null
                      ? "Choose File"
                      : "Selected: ${selectedfile!.name}",
                ),
              ),

              const SizedBox(height: 24),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      print("Selected Option: $selectedOption");
                      print("Description: ${descriptionctrl.text}");
                      print(
                        "File: ${selectedfile?.name ?? 'No file selected'}",
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
