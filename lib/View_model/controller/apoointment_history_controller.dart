import 'package:flutter/material.dart';
import 'package:med_care/models/appointment_history_model.dart';
import 'package:med_care/resporitary/appointment_resporitary.dart';
import 'package:med_care/view_model/services/tokens_and_sharedpref.dart';

class AppointmentController with ChangeNotifier {
  final AppointmentRepository _repository = AppointmentRepository();

  List<AppointmentHistoryModel> _appointments = [];
  bool _isLoading = false;
  String? _error;

  List<AppointmentHistoryModel> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// FETCH APPOINTMENTS
  Future<void> fetchAppointments() async {
    _setLoading(true);
    _error = null;

    try {
      final token = await getAccessToken();
      final patientId = await getPatientId();

      if (token == null || patientId == null) {
        _error = "Token or Patient ID not found.";
        _appointments = [];
      } else {
        _appointments = await _repository.fetchPatientAppointments(
          patientId: patientId,
          token: token,
        );
      }
    } catch (e) {
      _appointments = [];
      _error = "Failed to fetch appointments: $e";
    } finally {
      _setLoading(false);
    }
  }

  /// CANCEL APPOINTMENT
  Future<void> cancelAppointmentById(String appointmentId) async {
    _error = null;

    try {
      final token = await getAccessToken();

      if (token == null) {
        _error = "Access token not available.";
        return;
      }

      final result = await _repository.cancelAppointment(
        appointmentId: appointmentId,
        token: token,
      );

      if (result != null && result.status.toLowerCase() == 'success') {
        _appointments.removeWhere((appt) => appt.id.toString() == appointmentId);
      } else {
        _error = "Failed to cancel appointment.";
      }
    } catch (e) {
      _error = "Error cancelling appointment: $e";
    }

    notifyListeners();
  }

  void clearData() {
    _appointments = [];
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}
