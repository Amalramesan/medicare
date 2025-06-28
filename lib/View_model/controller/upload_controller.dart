import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadController with ChangeNotifier {
  String? selectedReportType;
  PlatformFile? pickedFile;
  bool isLoading = false;

  void setReportType(String? type) {
    selectedReportType = type;
    notifyListeners();
  }

  void setPickedFile(PlatformFile? file) {
    pickedFile = file;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
