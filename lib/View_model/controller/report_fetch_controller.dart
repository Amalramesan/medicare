import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:med_care/Models/report_fetch_model.dart';
import 'package:med_care/Resporitary/documents_resporitay.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';
import 'package:med_care/data/response/api_response.dart';

class ReportFetchController with ChangeNotifier {
  final _repository = DocumentRepository();
  final _storage = LocalStorageService();

  ApiResponse<List<Data>> reportsResponse = ApiResponse.loading();

  Future<void> fetchReports() async {
    reportsResponse = ApiResponse.loading();
    notifyListeners();

    try {
      await _storage.init(); 

      final patientId = _storage.patientId;

      if (patientId == null) {
        reportsResponse = ApiResponse.error("Patient ID not found");
        notifyListeners();
        return;
      }

      final ReportFetchModel? result = await _repository.fetchReports(
        patientId: patientId.toString(),
      );

      if (result != null && result.data.isNotEmpty) {
        reportsResponse = ApiResponse.completed(result.data);
      } else {
        reportsResponse = ApiResponse.error("No reports found.");
      }
    } catch (e) {
      log("Error fetching reports: $e");
      reportsResponse = ApiResponse.error("Something went wrong: $e");
    }

    notifyListeners();
  }
}
