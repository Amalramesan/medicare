import 'package:flutter/material.dart';
import 'package:med_care/View_model/services/store_auth_details.dart';
import 'package:med_care/models/appointment_history_model.dart';
import 'package:med_care/resporitary/appointment_resporitary.dart';

class AppointmentController with ChangeNotifier {
  final AppointmentRepository _repository = AppointmentRepository();
  final LocalStorageService _storage = LocalStorageService();

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
      await _storage.init();
      final patientId = _storage.patientId;
      debugPrint("Patient ID: $patientId");

      if (patientId == null) {
        _error = "Patient ID not found.";
        _appointments = [];
      } else {
        _appointments = await _repository.fetchPatientAppointments(
          patientId: patientId,
        );
      }
    } catch (e) {
      _appointments = [];
      _error = "Failed to fetch appointments: $e";
      debugPrint("Error fetching appointments: $e");
    } finally {
      _setLoading(false);
    }
  }

  /// BOOK APPOINTMENT
  Future<void> bookAppointment({
    required int doctorId,
    required String date,
    required String time,
  }) async {
    _setLoading(true);
    _error = null;

    try {
      await _storage.init();
      final patientId = _storage.patientId;

      if (patientId == null) {
        _error = "Patient ID not found.";
        return;
      }

      final result = await _repository.saveAppointment(
        doctorId: doctorId,
        patientId: patientId,
        date: date,
        time: time,
      );

      if (result.status.toLowerCase() == 'success') {
        // Refresh appointment list
        await fetchAppointments(); // <- this makes the new appointment appear
      } else {
        _error = "Failed to book appointment.";
      }
    } catch (e) {
      _error = "Error booking appointment: $e";
      debugPrint("Error booking appointment: $e");
    } finally {
      _setLoading(false);
    }
  }

  /// CANCEL APPOINTMENT
  Future<void> cancelAppointmentById(String appointmentId) async {
    _error = null;

    try {
      final result = await _repository.cancelAppointment(
        appointmentId: appointmentId,
      );

      if (result != null && result.status.toLowerCase() == 'success') {
        _appointments.removeWhere(
          (appt) => appt.id.toString() == appointmentId,
        );
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
