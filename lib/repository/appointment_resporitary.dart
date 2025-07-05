import 'dart:developer';
import 'package:med_care/data/Network/base_api_service.dart';
import 'package:med_care/data/Network/networ_api_service.dart';
import 'package:med_care/models/appointment_cancel_model.dart';
import 'package:med_care/models/appointment_history_model.dart';
import 'package:med_care/models/appointment_model.dart';
import 'package:med_care/Res/app_url.dart';

class AppointmentRepository {
  final BaseApiService _apiService = NetworApiService();
  //booking
  Future<AppointmentBooking> saveAppointment({
    required int doctorId,
    required int patientId,
    required String date,
    required String time,
  }) async {
    try {
      final data = {
        "doctor": doctorId,
        "patient_id": patientId,
        "date": date,
        "time": time,
      };

      final response = await _apiService.postApi(
        payload: data,
        endPoint: AppUrl.bookAppointment,
        isAuth: true,
      );

      return AppointmentBooking.fromJson(response);
    } catch (e) {
      log("Error booking appointment: $e");
      rethrow;
    }
  }

  //history
  Future<List<AppointmentHistoryModel>> fetchPatientAppointments({
    required int patientId,
  }) async {
    try {
      final response = await _apiService.getApi(
        endPoint: AppUrl.appointmentHistory,
        isAuth: true,
        getPayload: "?patient_id=$patientId",
      );

      log("Appointment History API response: $response");

      List<dynamic> items = [];

      if (response is List) {
        items = response;
      } else if (response is Map && response.containsKey('data')) {
        if (response['data'] is List) {
          items = response['data'];
        } else {
          throw Exception("Expected 'data' to be a List");
        }
      } else {
        throw Exception("Unexpected response format: $response");
      }
      return items
          .whereType<Map<String, dynamic>>() 
          .map((e) => AppointmentHistoryModel.fromJson(e))
          .toList();
    } catch (e) {
      log("Error fetching appointments: $e");
      rethrow;
    }
  }

  //cancel
  Future<AppointmentCancelModel?> cancelAppointment({
    required String appointmentId,
  }) async {
    final response = await _apiService.deleteApi(
      endPoint: AppUrl.appointmentCancel(appointmentId),
      isAuth: true,
    );

    if (response is Map<String, dynamic>) {
      return AppointmentCancelModel.fromJson(response);
    } else {
      log('Failed to cancel appointment: $response');
      return null;
    }
  }
}
