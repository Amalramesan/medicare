import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:med_care/data/Network/base_api_service.dart';
import 'package:med_care/data/Network/networ_api_service.dart';
import 'package:med_care/data/response/api_response.dart';
import 'package:med_care/Res/app_url.dart';
/// Controller responsible for handling the file upload process.
/// Responsibilities:
/// - Selecting report type and file
///- Managing upload state
/// - Sending file to backend via multipart request
class UploadController with ChangeNotifier {
  final BaseApiService _apiService = NetworApiService();

  String? selectedReportType;
  PlatformFile? pickedFile;
  ApiResponse<String> _uploadResponse = ApiResponse.loading();
  ApiResponse<String> get uploadResponse => _uploadResponse;
  String _error = '';
  String get error => _error;

  void setReportType(String? type) {
    selectedReportType = type;
    notifyListeners();
  }

  void setPickedFile(PlatformFile? file) {
    pickedFile = file;
    notifyListeners();
  }

  void _setUploadResponse(ApiResponse<String> response) {
    _uploadResponse = response;
    notifyListeners();
  }

  void _setError(String errorMsg) {
    _error = errorMsg;
    notifyListeners();
  }

  Future<void> uploadFile({String? description}) async {
    _setError('');
    if (pickedFile == null || selectedReportType == null) {
      _setUploadResponse(ApiResponse.error("Report type and file are required."));
      return;
    }

    _setUploadResponse(ApiResponse.loading());

    try {
      await _apiService.uploadMultipartFile(
        endPoint: AppUrl.uploadDocument,
        fields: {
          "report": selectedReportType!,
          if (description != null && description.isNotEmpty) "description": description,
        },
        file: File(pickedFile!.path!),
        fileField: "document",
        isAuth: true,
      );
      _setUploadResponse(ApiResponse.completed("File uploaded successfully"));
    } catch (e) {
      _setError("Upload failed: ${e.toString()}");
      _setUploadResponse(ApiResponse.error(_error));
    }
  }
}
