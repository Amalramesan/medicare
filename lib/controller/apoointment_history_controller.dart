import 'package:flutter/material.dart';
import 'package:med_care/Services/tokens_and_sharedpref.dart';
import 'package:med_care/Models/appointment_history_model.dart';
import 'package:med_care/Services/api_services.dart';

class AppointmentController with ChangeNotifier {
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

  // FETCH APPOINTMENTS
  Future<void> fetchAppointments() async {
    _setLoading(true);
    _error = null;

    try {
      final patientId = await getPatientId();
      if (patientId != null) {
        _appointments = await ApiServices.fetchPatientAppointments(patientId);
      } else {
        _appointments = [];
        _error = "Patient ID not found.";
      }
    } catch (e) {
      _appointments = [];
      _error = e.toString();
    }
    _setLoading(false);
  }

  // CANCEL APPOINTMENT
  Future<void> cancelAppointmentById(String appointmentId) async {
    try {
      final result = await ApiServices().cancelAppointment(appointmentId);
      if (result != null && result.status.toLowerCase() == 'success') {
        _appointments.removeWhere(
          (appt) => appt.id.toString() == appointmentId,
        );
        notifyListeners();
      } else {
        _error = "Failed to cancel appointment.";
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // CLEAR STATE WHEN NEW USER LOGS IN
  void clearData() {
    _appointments = [];
    _error = null;
    _setLoading(false);
    notifyListeners();
  }
}
