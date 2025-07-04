import 'dart:developer';
import 'package:med_care/Models/doctor_model.dart';
import 'package:med_care/Res/app_url.dart';
import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Network/networ_api_service.dart';

class DoctorRepository {
  final BaseApiService _apiService = NetworApiService();

  /// Fetch list of all doctors
  Future<List<DoctorModel>> fetchDoctors() async {
    try {
      final response = await _apiService.getApi(
        endPoint: AppUrl.doctors,
        isAuth: false,
      );

      log('Doctor API Response: $response'); // Add logging
      log('Response type: ${response.runtimeType}');

      List<dynamic> items = [];

      // Handle both response formats
      if (response is List) {
        items = response;
      } else if (response is Map && response.containsKey('data')) {
        if (response['data'] is List) {
          items = response['data'];
        } else {
          throw Exception('Data field is not a List');
        }
      } else {
        throw Exception('Unexpected response format: $response');
      }

      // Safe conversion with type checking
      return items.whereType<Map<String, dynamic>>().map((e) {
        try {
          return DoctorModel.fromJson(e);
        } catch (e) {
          log('Error parsing doctor item: $e\nItem: $e');
          throw Exception('Failed to parse doctor data: $e');
        }
      }).toList();
    } catch (e) {
      log('Failed to fetch doctors: $e');
      throw Exception('Failed to load doctors: ${e.toString()}');
    }
  }

  /// Check a doctor's availability on a given date
  Future<bool> isDoctorAvailable(String doctorId, String date) async {
    try {
      final response = await _apiService.getApi(
        endPoint: AppUrl.doctorAvailability(doctorId, date),
        isAuth: false,
      );

      if (response is Map && response.containsKey("data")) {
        final data = response["data"];
        return data is List && data.isNotEmpty;
      } else {
        throw Exception("Invalid response format: $response");
      }
    } catch (e) {
      log('Failed to check availability: $e');
      throw Exception('Failed to check doctor availability: $e');
    }
  }
}
