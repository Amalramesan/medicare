import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Network/networ_api_service.dart';
import 'package:med_care/Models/appointment_cancel_model.dart';
import 'package:med_care/Models/appointment_history_model.dart';
import 'package:med_care/Models/appointment_model.dart';
import 'package:med_care/Res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<AppointmentBooking> saveAppointment({
    required int doctorId,
    required int patientId,
    required String date,
    required String time,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) throw Exception('Authentication token not found');

    final data = {
      "doctor": doctorId,
      'patient_id': patientId,
      'date': date,
      'time': time,
    };

    final response = await _apiService.getPostApiResponse(
      AppUrl.bookAppointment,
      data,
    );

    return AppointmentBooking.fromJson(response);
  }

  Future<List<AppointmentHistoryModel>> fetchPatientAppointments(int patientId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) throw Exception('Token not found');

    final url = '${AppUrl.appointmentHistory}?patient_id=$patientId';

    final response = await _apiService.getGetApiResponse(url);

    if (response is List) {
      return response.map<AppointmentHistoryModel>((e) => AppointmentHistoryModel.fromJson(e)).toList();
    } else if (response is Map && response.containsKey('data')) {
      final List data = response['data'];
      return data.map<AppointmentHistoryModel>((e) => AppointmentHistoryModel.fromJson(e)).toList();
    } else {
      throw Exception("Unexpected response format: $response");
    }
  }

  Future<AppointmentCancelModel?> cancelAppointment(String appointmentId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) throw Exception('Token not found');

    final url = AppUrl.appointmentCancel(appointmentId);

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
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
