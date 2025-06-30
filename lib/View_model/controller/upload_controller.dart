import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:med_care/data/response/api_response.dart';

class UploadController with ChangeNotifier {
  String? selectedReportType;
  PlatformFile? pickedFile;
  ApiResponse<String> uploadResponse = ApiResponse<String>.loading();

  void setReportType(String? type) {
    selectedReportType = type;
    notifyListeners();
  }

  void setPickedFile(PlatformFile? file) {
    pickedFile = file;
    notifyListeners();
  }

  Future<void> uploadFile() async {
    if (pickedFile == null) return;

    uploadResponse = ApiResponse.loading();
    notifyListeners();

    try {
      // Simulate API upload
      await Future.delayed(const Duration(seconds: 2));

      // You would normally make an API call here and check response
      uploadResponse = ApiResponse.completed("File uploaded successfully");
    } catch (e) {
      uploadResponse = ApiResponse.error("Upload failed: ${e.toString()}");
    }

    notifyListeners();
  }
}
