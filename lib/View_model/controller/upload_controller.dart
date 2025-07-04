import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Res/app_url.dart';

import 'package:med_care/data/response/api_response.dart';

class UploadController with ChangeNotifier {
  final BaseApiService _apiService = NetworApiService(); 

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

  Future<void> uploadFile({String? description}) async {
    if (pickedFile == null || selectedReportType == null) {
      uploadResponse = ApiResponse.error("Report type and file are required.");
      notifyListeners();
      return;
    }

    uploadResponse = ApiResponse.loading();
    notifyListeners();

    try {
      final result = await _apiService.uploadMultipartFile(
        endPoint: AppUrl.uploadDocument,
        fields: {
          "report": selectedReportType!,
          if (description != null && description.isNotEmpty)
            "description": description,
        },
        file: File(pickedFile!.path!),
        fileField: "document",
        isAuth: true, // ✅ Automatically adds token
      );

      uploadResponse = ApiResponse.completed("File uploaded successfully");
    } catch (e) {
      uploadResponse = ApiResponse.error("Upload failed: ${e.toString()}");
    }

    notifyListeners();
  }
}
