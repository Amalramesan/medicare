import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/doctor_model.dart';
import 'package:med_care/Res/app_url.dart';

class DoctorRepository {
  final BaseApiService _apiService = NetworkApiService();

  // Fetch all doctors
  Future<List<DoctorModel>> fetchDoctors() async {
    final response = await _apiService.getGetApiResponse(AppUrl.doctors);

    if (response is List) {
      return response.map((e) => DoctorModel.fromJson(e)).toList();
    } else {
      throw Exception('Unexpected response format: $response');
    }
  }

  // Check doctor availability
  Future<bool> isDoctorAvailable(String doctorId, String date) async {
    final response = await _apiService.getGetApiResponse(
      AppUrl.doctorAvailability(doctorId, date),
    );

    if (response is Map && response.containsKey("data")) {
      final data = response["data"];
      return data is List && data.isNotEmpty;
    } else {
      throw Exception("Invalid response format: $response");
    }
  }
}
