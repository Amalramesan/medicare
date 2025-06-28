import 'dart:io';
import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/report_fetch_model.dart';
import 'package:med_care/Models/upload_model.dart';
import 'package:med_care/Res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<UploadModel?> uploadDocument({
    required File documentFile,
    required String report,
    required String description, required int patientId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final patientId = prefs.getInt('patient_id');

    if (token == null || patientId == null) {
      throw Exception('Authentication or Patient ID not found');
    }

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
  }
//fetch document
  Future<ReportFetchModel?> fetchReports() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) throw Exception('No token found');

    final response = await _apiService.getGetApiResponse(AppUrl.fetchDocument);

    return ReportFetchModel.fromJson(response);
  }
}
