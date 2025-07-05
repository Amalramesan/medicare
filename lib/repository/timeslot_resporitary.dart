import 'dart:developer';
import 'package:med_care/data/Network/base_api_service.dart';
import 'package:med_care/data/Network/networ_api_service.dart';
import 'package:med_care/Models/time_slote_model.dart';
import 'package:med_care/Res/app_url.dart';

class TimeSlotRepository {
  final BaseApiService _apiService = NetworApiService();

  Future<TimeSlots> fetchTimeSlots(String doctorId, String date) async {
    try {
      final url = AppUrl.fetchTimeSlots(doctorId, date);

      final responseJson = await _apiService.getApi(
        endPoint: url,
        isAuth: true, // Set to true if token is required
      );

      log("TimeSlots API Response: $responseJson");
      return TimeSlots.fromJson(responseJson);
    } catch (e) {
      log("Error fetching time slots: $e");
      rethrow;
    }
  }
}
