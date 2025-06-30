import 'dart:io';
import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/report_fetch_model.dart';
import 'package:med_care/Models/upload_model.dart';
import 'package:med_care/Res/app_url.dart';

class DocumentRepository {
  final BaseApiService _apiService = NetworkApiService();

  /// Upload medical document
  Future<UploadModel?> uploadDocument({
    required File documentFile,
    required String report,
    required String description,
    required int patientId,
    required String token,
  }) async {
    try {
      final response = await (_apiService as NetworkApiService).uploadMultipartFile(
        url: AppUrl.uploadDocument,
        token: token,
        file: documentFile,
        fileField: 'document',
        fields: {
          'report': report,
          'description': description,
          'patient_id': patientId.toString(),
        },
      );

      return UploadModel.fromJson(response);
    } catch (e) {
      throw Exception("Document upload failed: $e");
    }
  }

  /// Fetch uploaded reports
  Future<ReportFetchModel?> fetchReports({
    required String token,
  }) async {
    try {
      final response = await _apiService.getGetApiResponse(
        AppUrl.fetchDocument,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return ReportFetchModel.fromJson(response);
    } catch (e) {
      throw Exception("Fetching reports failed: $e");
    }
  }
}
