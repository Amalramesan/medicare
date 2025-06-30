import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/appointment_cancel_model.dart';
import 'package:med_care/Models/appointment_history_model.dart';
import 'package:med_care/Models/appointment_model.dart';
import 'package:med_care/Res/app_url.dart';

class AppointmentRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<AppointmentBooking> saveAppointment({
    required int doctorId,
    required int patientId,
    required String date,
    required String time,
    required String token,
  }) async {
    final data = {
      "doctor": doctorId,
      "patient_id": patientId,
      "date": date,
      "time": time,
    };

    final response = await _apiService.getPostApiResponse(
      AppUrl.bookAppointment,
      data,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    return AppointmentBooking.fromJson(response);
  }

  Future<List<AppointmentHistoryModel>> fetchPatientAppointments({
    required int patientId,
    required String token,
  }) async {
    final url = '${AppUrl.appointmentHistory}?patient_id=$patientId';

    final response = await _apiService.getGetApiResponse(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response is List) {
      return response
          .map<AppointmentHistoryModel>((e) => AppointmentHistoryModel.fromJson(e))
          .toList();
    } else if (response is Map && response.containsKey('data')) {
      final List data = response['data'];
      return data
          .map<AppointmentHistoryModel>((e) => AppointmentHistoryModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Unexpected response format: $response");
    }
  }

  Future<AppointmentCancelModel?> cancelAppointment({
    required String appointmentId,
    required String token,
  }) async {
    final url = AppUrl.appointmentCancel(appointmentId);

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return AppointmentCancelModel.fromJson(json);
    } else {
      log('Failed to cancel appointment: ${response.body}');
      return null;
    }
  }
}
