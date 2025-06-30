import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/doctor_model.dart';
import 'package:med_care/Res/app_url.dart';

class DoctorRepository {
  final BaseApiService _apiService = NetworkApiService();

  /// Fetch list of all doctors
  Future<List<DoctorModel>> fetchDoctors() async {
    try {
      final response = await _apiService.getGetApiResponse(
        AppUrl.doctors,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response is List) {
        return response.map((e) => DoctorModel.fromJson(e)).toList();
      } else {
        throw Exception('Unexpected response format: $response');
      }
    } catch (e) {
      throw Exception('Failed to fetch doctors: $e');
    }
  }

  /// Check a doctor's availability on a given date
  Future<bool> isDoctorAvailable(String doctorId, String date) async {
    try {
      final response = await _apiService.getGetApiResponse(
        AppUrl.doctorAvailability(doctorId, date),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response is Map && response.containsKey("data")) {
        final data = response["data"];
        return data is List && data.isNotEmpty;
      } else {
        throw Exception("Invalid response format: $response");
      }
    } catch (e) {
      throw Exception('Failed to check doctor availability: $e');
    }
  }
}
