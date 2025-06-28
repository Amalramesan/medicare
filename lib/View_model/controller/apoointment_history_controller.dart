import 'package:flutter/material.dart';
import 'package:med_care/Models/appointment_history_model.dart';
import 'package:med_care/Models/appointment_cancel_model.dart';
import 'package:med_care/Resporitary/appointment_resporitary.dart';
import 'package:med_care/View_model/services/tokens_and_sharedpref.dart';

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
      final patientId = await getPatientId();
      if (patientId != null) {
        _appointments = await _repository.fetchPatientAppointments(patientId);
      } else {
        _appointments = [];
        _error = "Patient ID not found.";
      }
    } catch (e) {
      _appointments = [];
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  /// CANCEL APPOINTMENT
  Future<void> cancelAppointmentById(String appointmentId) async {
    try {
      AppointmentCancelModel? result = await _repository.cancelAppointment(appointmentId);
      if (result != null && result.status.toLowerCase() == 'success') {
        _appointments.removeWhere((appt) => appt.id.toString() == appointmentId);
      } else {
        _error = "Failed to cancel appointment.";
      }
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /// CLEAR STATE WHEN USER LOGS OUT / SWITCHES
  void clearData() {
    _appointments = [];
    _error = null;
    _setLoading(false);
    notifyListeners();
  }
}
