import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:med_care/Models/report_fetch_model.dart';
import 'package:med_care/Resporitary/documents.dart';
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
      final token = await _storage.accessToken;

      if (token == null) {
        throw Exception("Token not found");
      }

      final result = await _repository.fetchReports(token: token);

      if (result != null && result.data.isNotEmpty) {
        reportsResponse = ApiResponse.completed(result.data);
      } else {
        reportsResponse = ApiResponse.error("No reports found");
      }
    } catch (e) {
      log("Error fetching reports: $e");
      reportsResponse = ApiResponse.error("Something went wrong: $e");
    }

    notifyListeners();
  }
}
