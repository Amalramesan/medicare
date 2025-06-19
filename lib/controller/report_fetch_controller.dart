import 'package:flutter/material.dart';
import 'package:med_care/Models/report_fetch_model.dart';
import 'package:med_care/services/api_services.dart';

class ReportFetchController with ChangeNotifier {
  bool isLoading = false;
  List<Data> reports = [];

  Future<void> fetchReports() async {
    isLoading = true;
    notifyListeners();

    try {
      final ReportFetchModel? result = await ApiServices.fetchReports();

      if (result != null && result.data != null && result.data!.isNotEmpty) {
        reports = result.data!;
      } else {
        reports = []; // Handle empty or null data
      }
    } catch (e) {
      print("Error fetching reports: $e");
      reports = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
