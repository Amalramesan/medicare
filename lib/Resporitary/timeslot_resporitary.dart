
import 'dart:developer';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/time_slote_model.dart';
import 'package:med_care/Res/app_url.dart';

Future<TimeSlots> fetchTimeSlots(String doctorId, String date) async {
  try {
    final url = AppUrl.fetchTimeSlots(doctorId, date); 
    final _apiService = NetworkApiService();

    final responseJson = await _apiService.getGetApiResponse(url);

    log("TimeSlots API Response: $responseJson");
    return TimeSlots.fromJson(responseJson);
  } catch (e) {
    log("Error fetching time slots: $e");
    rethrow; 
  }
}
