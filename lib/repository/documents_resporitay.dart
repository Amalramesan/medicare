import 'dart:developer';
import 'dart:io';
import 'package:med_care/data/Network/base_api_service.dart';
import 'package:med_care/data/Network/networ_api_service.dart';
import 'package:med_care/Models/report_fetch_model.dart';
import 'package:med_care/Models/upload_model.dart';
import 'package:med_care/Res/app_url.dart';
///used to handle upload documents api calls
class DocumentRepository {
  final BaseApiService _apiService = NetworApiService();

  /// Upload medical document
  Future<UploadModel?> uploadDocument({
    required File documentFile,
    required String report,
    required String description,
    required int patientId,
  }) async {
    try {
      final response = await _apiService.uploadMultipartFile(
        endPoint: AppUrl.uploadDocument,
        file: documentFile,
        fileField: 'document',
        fields: {
          'report': report,
          'description': description,
          'patient_id': patientId.toString(),
        },
        isAuth: true, // Use token stored via LocalStorageService
      );

      return UploadModel.fromJson(response);
    } catch (e) {
      throw Exception("Document upload failed: $e");
    }
  }

  /// Fetch uploaded reports
Future<ReportFetchModel?> fetchReports({
  required String patientId,
}) async {
  try {
    final response = await _apiService.getApi(
      endPoint: AppUrl.fetchDocument,
      getPayload: "?patient_id=$patientId",
      isAuth: true,
    );

    // Debug print to see actual API response
    log("Raw fetchReports response: $response");

    final model = ReportFetchModel.fromJson(response);
    log("Parsed reports length: ${model.data.length}");

    return model;
  } catch (e) {
    log("Error response: $e");
    throw Exception("Fetching reports failed: $e");
  }
}

}
