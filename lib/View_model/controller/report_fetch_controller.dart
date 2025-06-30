import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:med_care/Models/report_fetch_model.dart';
import 'package:med_care/Resporitary/documents.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';

class ReportFetchController with ChangeNotifier {
  final _repository = DocumentRepository();
  final _storage = LocalStorageService();

  bool isLoading = false;
  List<Data> reports = [];

  Future<void> fetchReports() async {
    isLoading = true;
    notifyListeners();

    try {
      final token = await _storage.accessToken;

      if (token == null) {
        throw Exception("Token not found");
      }

      final result = await _repository.fetchReports(token: token);

      if (result != null && result.data.isNotEmpty) {
        reports = result.data;
      } else {
        reports = [];
      }
    } catch (e) {
      log("Error fetching reports: $e");
      reports = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
